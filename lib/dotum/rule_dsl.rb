require "rbconfig"

module Dotum::RuleDSL

  def success!(reason=nil)
    throw :finish_rule, [:success, reason]
  end

  def failure!(reason=nil)
    throw :finish_rule, [:failure, reason]
  end

  def skip!(reason=nil)
    throw :finish_rule, [:skip, reason]
  end

  def platform?(name)
    os = RbConfig::CONFIG["host_os"].downcase

    case name
    when /os\s?x/i     then /mac|darwin/      === os
    when /win(dows)?/i then /mswin|win|mingw/ === os
    when /linux/i      then /linux|cygwin/    === os
    when /bsd/i        then /bsd/             === os
    when /solaris/i    then /solaris|sunos/   === os
    else
      if name.is_a? Regexp
        name === os
      else
        Regexp.new(name, "i") === os
      end
    end
  end

  def available?(command)
    # TODO: Windows friendly.
    `which "#{command}"`
    $?.success?
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
    rule_class_name = sym.to_s.split("_").map(&:capitalize).join.to_sym

    begin
      rule_class = Dotum::Rules.const_get(rule_class_name)
    rescue LoadError
      raise NoMethodError, "Unknown rule #{sym}.  Tried to load Dotum::Rules::#{rule_class_name}: #{$!.message}"
    end

    Dotum::RuleDSL.module_eval <<-end_eval, __FILE__, __LINE__
      def #{sym}(*args, &block)
        Dotum::Rules::#{rule_class_name}.exec(context, *args, &block)
      end
    end_eval

    send(sym, *args, &block)
  end

end
