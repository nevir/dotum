namespace :spec do

  desc "Run tests with code coverage"
  task :coverage do
    prev = ENV["COVERAGE"]
    ENV["COVERAGE"] = "yes"

    Rake::Task["spec"].execute

    if RUBY_PLATFORM.include? "darwin"
      `open #{File.join(PROJECT_ROOT, "coverage", "index.html")}`
    end

    ENV["COVERAGE"] = prev
  end

end
