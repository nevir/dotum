# `OptionsContext`

# An `OptionsContext` is a Hash-like object that also provides DSL-like behavior
# where you can set values by calling them:
#
#     Dotum::OptionsContext.new(configs).instance_eval do
#       some_field 'some value'
#     end
#
# If configured with `some_field`, the above would result in an `OptionsContext`
# that contains `{:some_field => 'some value'}`
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
