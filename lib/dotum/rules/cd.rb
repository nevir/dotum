# encoding: utf-8

class Dotum::Rules::Cd < Dotum::AbstractRules::Base

  # Special case; we don't accept an options block.
  def initialize(context, destination, &block)
    super(context)

    @destination = @context.target_dir.join(destination)
    @block       = block
  end

  def pretty_subject
    @destination.pretty
  end

private

  def execute
    Dir.chdir(@destination, &@block)
  end

end
