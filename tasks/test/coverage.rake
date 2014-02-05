namespace :test do

  desc 'Run tests with code coverage'
  task :coverage do
    prev_coverage = ENV['COVERAGE']
    prev_preload = ENV['PRELOAD_ALL']
    ENV['COVERAGE'] = 'yes'
    ENV['PRELOAD_ALL'] = 'yes'

    begin
      # preload_all!
      Rake::Task['test:unit'].execute

      if RUBY_PLATFORM.include? 'darwin'
        `open #{File.join(PROJECT_ROOT, 'coverage', 'index.html')}`
      end

    ensure
      ENV['PRELOAD_ALL'] = prev_preload
      ENV['COVERAGE'] = prev_coverage
    end
  end

end
