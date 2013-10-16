class Dotum::Rules::Run < Dotum::AbstractRules::Base

  def initialize(context, *command)
    super(context)

    @command = command
  end

  def pretty_subject
    @command.join(' ')
  end

private

  def execute
    Kernel.system(*@command)

    failure! unless $CHILD_STATUS.success?
  end

end
