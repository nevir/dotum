class Dotum::Rules::Link < Dotum::AbstractRules::GlobbableFiles
  private

  def execute
    link_path = @destination.symlink? ? @destination.link_path : nil

    success! 'Already linked' if link_path == @source
    if @destination.exists?
      if link_path
        failure! "Target already exists as a symlink to #{link_path}"
      else
        failure! 'Target already exists'
      end
    end

    run 'ln', '-s', @source, @destination
  end
end
