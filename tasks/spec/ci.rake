namespace :spec do

  desc "Run the tests in CI mode"
  task :ci do
    prev = ENV["CONTINUOUS_INTEGRATION"]
    ENV["CONTINUOUS_INTEGRATION"] = "yes"

    Rake::Task["spec:coverage"].execute
    Rake::Task["spec:mutate"].execute

    ENV["CONTINUOUS_INTEGRATION"] = prev
  end

end
