# encoding: utf-8

class Dotum::RuleRunner
  include Dotum::RuleDSL

  def self.eval(context, *args, &block)
    new(context).instance_eval(*args, &block)
  end

  def initialize(context)
    @context = context
  end

  attr_reader :context

end
