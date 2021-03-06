namespace :test do

  desc 'Check the Dotum source for style violations and lint'
  begin
    require 'rubocop/rake_task'
    Rubocop::RakeTask.new(:style) do |task|
      task.requires << 'rubocop-rspec'
    end
  rescue LoadError
    task :style do
      puts 'Rubocop is not supported for this platform.'
    end
  end

end
