require 'rspec/core/rake_task'

namespace :test do

  desc 'Run the unit tests'
  RSpec::Core::RakeTask.new(:unit) do |task|
    # Nothing to configure just yet.
  end

end
