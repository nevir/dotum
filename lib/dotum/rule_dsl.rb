# `RuleDSL`
# =========
require 'rbconfig'

# All DSL methods available to rules.
module Dotum::RuleDSL
  def success!(reason = nil)
    throw :finish_rule, [:success, reason]
  end

  def failure!(reason = nil)
    throw :finish_rule, [:failure, reason]
  end

  def skip!(reason = nil)
    throw :finish_rule, [:skip, reason]
  end

  def platform?(name)
    os = RbConfig::CONFIG['host_os'].downcase

    case name
    when /os\s?x/i     then /mac|darwin/      =~ os
    when /win(dows)?/i then /mswin|win|mingw/ =~ os
    when /linux/i      then /linux|cygwin/    =~ os
    when /bsd/i        then /bsd/             =~ os
    when /solaris/i    then /solaris|sunos/   =~ os
    else
      regex = name.is_a?(Regexp) ? name : Regexp.new(name, 'i')
      regex =~ os
    end
  end

  def available?(command)
    # TODO: Windows friendly.
    `which "#{command}"`
    $CHILD_STATUS.success?
  end

  def package_dir
    context.package_dir
  end

  def target_dir
    context.target_dir
  end

  def state_dir
    context.state_dir
  end

  def method_missing(sym, *args, &block)
    rule_class_name = sym.to_s.split('_').map(&:capitalize).join.to_sym

    begin
      Dotum::Rules.const_get(rule_class_name)
    rescue LoadError
      details = "Tried to load Dotum::Rules::#{rule_class_name}: #{$ERROR_INFO}"
      raise NoMethodError, "Unknown rule #{sym}. #{details}"
    end

    Dotum::RuleDSL.module_eval <<-end_eval, __FILE__, __LINE__
      def #{sym}(*args, &block)
        Dotum::Rules::#{rule_class_name}.exec(context, *args, &block)
      end
    end_eval

    send(sym, *args, &block)
  end
end
