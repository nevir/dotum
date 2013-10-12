class Dotum::OptionsContext < Hash

  def initialize(option_configs)
    @known_options = Set.new(option_configs.keys)
  end

  def method_missing(sym, *args)
    super if args.size != 1

    fail NameError, "Unknown option '#{sym}'" unless @known_options.include? sym

    self[sym] = args[0]
  end

end
