require 'rubocop/rake_task'

namespace :test do

  desc "Check the Dotum source for style violations and lint"
  Rubocop::RakeTask.new(:style) do
    # Nothing to configure just yet.
  end

end
