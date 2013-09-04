# encoding: utf-8

namespace :spec do

  desc "Run tests with code coverage"
  task :coverage do
    prev_coverage = ENV["COVERAGE"]
    prev_full_run = ENV["FULL_COVERAGE_RUN"]
    ENV["COVERAGE"] = "yes"
    ENV["FULL_COVERAGE_RUN"] = "yes"

    begin
      Rake::Task["spec"].execute

      if RUBY_PLATFORM.include? "darwin"
        `open #{File.join(PROJECT_ROOT, "coverage", "index.html")}`
      end

    ensure
      ENV["FULL_COVERAGE_RUN"] = prev_full_run
      ENV["COVERAGE"] = prev_coverage
    end
  end

end
