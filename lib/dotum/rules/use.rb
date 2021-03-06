# `use`
# =====

# `use` executes the rules described by a particular directory.
#
# If that directory contains a `rules.dotum`, it will be executed. Otherwise,
# the [default rule behavior](../../default_rules.html) will be executed.
class Dotum::Rules::Use < Dotum::AbstractRules::OptionsBase
  shorthand :path

  required(:path) { |v| package_dir.join(v) }

  def self.expand_options(context, options)
    paths = context.package_dir.glob(options[:path], &:directory?)
    paths.reject! &:hidden?

    paths.map { |p| options.merge(:path => p) }
  end

  def pretty_subject
    @path.pretty
  end

  private

  def execute
    failure! "Expected #{@path} to be a directory!" unless @path.directory?

    rule_file = @path.join('rules.dotum')
    unless rule_file.file?
      rule_file = Dotum::DATA_PATH.join('default_rules.dotum')
    end

    new_context = context.fork(:package_dir => @path)

    Dotum::RuleRunner.eval(new_context, rule_file.read, rule_file)
  end
end
