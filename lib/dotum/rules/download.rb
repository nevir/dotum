class Dotum::Rules::Download < Dotum::AbstractRules::OptionsBase

  shorthand :uri => :destination

  required :uri
  standard :destination
  optional :mode
  optional :owner
  optional :group

  def pretty_subject
    "#{@destination.pretty} (#{@uri})"
  end

private

  def execute
    if @destination.exists? && !@destination.file?
      failure! "#{@destination} already exists and is not a file!"
    end

    # TODO: ETag support!
    run "curl", "--output", @destination, @uri

    run "chmod", @mode, @destination  if @mode
    run "chown", @owner, @destination if @owner
    run "chgrp", @group, @destination if @group
  end

end
