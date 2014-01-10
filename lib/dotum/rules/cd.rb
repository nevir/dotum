# `cd`
# ====

# Changes the current working directory for scripts.
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
    # Should this also change `target_dir`?
    Dir.chdir(@destination, &@block)
  end
end
