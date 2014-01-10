module Dotum::StandardOptions::Destination
  extend Dotum::RuleOptionsDSL

  optional(:destination) { |v| context.target_dir.join(v) }

  def preprocess_for_destination
    # It's required by the time you reach the preprocessing step; but not
    # necessarily required for the shorthand.
    failure! "Option 'destination' is required." if @destination.nil?

    parent_dir = @destination.dirname
    if parent_dir.exists? && !parent_dir.directory?
      failure!(
        "Parent path #{parent_dir} is not a directory; cannot write into it!"
      )
    end

    run 'mkdir', '-p', parent_dir unless parent_dir.directory?
  end
  register_preprocessor :preprocess_for_destination
end
