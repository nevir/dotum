require "set"

class Dotum::OptionsContext < Hash

  def initialize(option_configs)
    @known_options = Set.new(option_configs.keys)
  end

  def method_missing(sym, *args)
    super if args.size != 1

    unless @known_options.include? sym
      raise NameError, "Unknown option '#{sym}'"
    end

    self[sym] = args[0]
  end

end
