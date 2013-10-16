namespace :test do

  desc "Run the tests in CI mode"
  task :ci do
    prev = ENV["CONTINUOUS_INTEGRATION"]
    ENV["CONTINUOUS_INTEGRATION"] = "yes"

    Rake::Task["test:coverage"].execute

    ENV["CONTINUOUS_INTEGRATION"] = prev
  end

end
