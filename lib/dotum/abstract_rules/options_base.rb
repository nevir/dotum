# encoding: utf-8

class Dotum::AbstractRules::OptionsBase < Dotum::AbstractRules::Base

  def self.exec(context, *args, &block)
    options = option_defaults.merge(expand_shorthand(*args))
    options.merge! eval_options_block(&block) if block

    if errors = validate_options(options)
      raise "Validation errors: #{errors.inspect}"
    end

    if respond_to? :expand_options
      expand_options(context, options).map { |rule_options|
        new(context, rule_options).exec
      }
    else
      new(context, options).exec
    end
  end

  def initialize(context, options)
    super(context)

    options.each do |option, value|
      filter = self.class.option_configs[option][:filter]
      value = instance_exec(value, &filter) if filter && !value.nil?

      instance_variable_set(:"@#{option}", value)
    end
  end

end
