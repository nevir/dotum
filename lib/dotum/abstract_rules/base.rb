class Dotum::AbstractRules::Base
  extend Dotum::RuleOptionsDSL
  include Dotum::RuleDSL

  def self.exec(context, *args, &block)
    new(context, *args, &block).exec
  end

  def self.pretty
    @pretty ||= name.split('::').last.gsub(
      /([^A-Z])([A-Z]+)/, '\\1_\\2'
    ).downcase
  end

  def initialize(context)
    @context = context.child
  end

  def exec
    context.logger.start_rule(self)

    status, reason = catch(:finish_rule) do
      preprocess
      execute

      success!
    end

    context.logger.finish_rule(self, status, reason)
    fail "Rule failed: #{reason}" if status == :failure

    self
  end

  attr_reader :context

  def pretty_subject
    fail NotImplementedError, "#{self.class}#pretty_subject"
  end

  protected

  def preprocess
    self.class.preprocessor_methods.each do |sym|
      send(sym)
    end
  end

  def execute
    fail NotImplementedError, "#{self.class}#execute"
  end

end
