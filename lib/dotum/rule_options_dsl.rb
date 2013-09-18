# encoding: utf-8

module Dotum::RuleOptionsDSL

  OptionConfig = Struct.new(:filter, :validator, :default)


  # DSL
  # ---

  def shorthand(*args)
    @shorthand_config = args
  end

  def required(option, &block)
    (@option_configs ||= {})[option] = OptionConfig.new(
      block,
      proc { |v| "Option '#{option}' is required." if v.nil? }
    )
  end

  def optional(option, default=nil, &block)
    (@option_configs ||= {})[option] = OptionConfig.new(block, nil, default)
  end

  def standard(option)
    option_module_name = option.to_s.split("_").map(&:capitalize).join

    begin
      option_module = Dotum::StandardOptions.const_get(option_module_name)
    rescue LoadError
      raise ArgumentError, "Unknown standard option '#{option}'.  Tried to load Dotum::StandardOptions::#{option_module_name}: #{$!}"
    end

    module_configs = option_module.instance_variable_get(:@option_configs)
    unless module_configs && module_configs[option]
      raise "Dotum::StandardOptions::#{option_module_name} is misconfigured; expected it to define the option '#{option}'"
    end

    include option_module
  end

  def register_preprocessor(sym)
    @preprocessors ||= []
    @preprocessors.push(sym)
  end


  # Configuration Management
  # ------------------------

  def option_configs
    ancestors.reverse_each.reduce({}) { |result, ancestor|
      if ancestor.instance_variable_defined? :@option_configs
        result.merge(ancestor.instance_variable_get(:@option_configs))
      else
        result
      end
    }
  end

  def option_defaults
    {}.tap do |defaults|
      option_configs.each do |option, config|
        defaults[option] = config[:default] unless config[:default].nil?
      end
    end
  end

  def preprocessor_methods
    ancestors.map { |ancestor|
      ancestor.instance_variable_get(:@preprocessors)
    }.compact.flatten.uniq
  end

  def shorthand_config
    return @shorthand_config if defined? @shorthand_config
    return superclass.shorthand_config if superclass.respond_to? :shorthand_config

    []
  end

  def expand_shorthand(*args)
    result = {}
    shorthand_config.zip(args).each do |config, value|
      case config
      when Symbol then result[config] = value
      when Hash
        if value.is_a? Hash
          result[config.keys.first]   = value.keys.first
          result[config.values.first] = value.values.first
        else
          result[config.keys.first] = value
        end
      end
    end

    result.reject! { |_,v| v.nil? }
    result
  end

  def eval_options_block(&block)
    options = Dotum::OptionsContext.new(option_configs)
    options.instance_eval(&block)

    options
  end

  def process_options(options, context=nil)
    result = options.dup
    options.each do |option, value|
      next if value.nil?
      next unless filter = option_configs[option][:filter]

      if context
        result[option] = context.instance_exec(value, &filter)
      else
        result[option] = filter.call(value)
      end
    end

    result
  end

  def validate_options(options)
    errors = []
    option_configs.each do |option, config|
      next unless validator = config[:validator]
      next unless error = validator.call(options[option])

      errors.push(error)
    end

    errors.size > 0 ? errors : nil
  end

end
