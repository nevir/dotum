source "https://rubygems.org"

gemspec

# No gem would be complete without rake tasks - http://rake.rubyforge.org/
gem "rake", "~> 10.1"

group :test do
  # Our preferred unit testing library - https://www.relishapp.com/rspec
  gem "rspec", "~> 2.14"

  # The preferred code mutation library.
  gem "mutant", "~> 0.3.rc", :platforms => [:ruby_19, :ruby_20]

  # Temporary until mutant depends on 0.1.3+
  gem "unparser", ">= 0.1.3"

  # Cover all the things - https://github.com/colszowka/simplecov
  gem "simplecov", "~> 0.7"

  # Code coverage in badge form - https://coveralls.io/
  gem "coveralls", "~> 0.7"

  # Style enforcement & linting
  gem "rubocop", "~> 0.14.1"
end

group :debugging do
  # A REPL like IRB, but much better - http://pryrepl.org/
  gem "pry", "~> 0.9"

  # Don't leave home without a debugger!
  gem "debugger", "~> 1.6", :platforms => :mri
end

group :guard do
  # A generic file system event handler; spin it up and see the tests fly
  gem "guard", "~> 2.0"

  # Guard configuration to manage our spork drb environments
  gem "guard-spork", "~> 1.5"

  # Guard configuration & hooks for rspec
  gem "guard-rspec", "~> 4.0"

  # File system event hooks for OS X
  gem "rb-fsevent", "~> 0.9"

  # File system event hooks for Linux
  gem "rb-inotify", "~> 0.9"

  # File system event hooks for Windows
  gem "rb-fchange", "~> 0.0"

  # OS X 10.8+ notification center support
  gem "terminal-notifier-guard", "~> 1.5"

  # libnotify bindings (Linux)
  gem "libnotify", "~> 0.8"

  # notifu adapter (Windows)
  gem "rb-notifu", "~> 0.0"
end
