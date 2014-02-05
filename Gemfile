source 'https://rubygems.org'

gemspec

# What you're using right here.
gem 'bundler', '~> 1.5'

# No gem would be complete without rake tasks
gem 'rake', '~> 10.1'

group :test do
  # Our preferred unit testing library.
  gem 'rspec', '~> 2.14'

  # Cover all the things.
  gem 'simplecov', '~> 0.8'

  # Code coverage in badge form.
  gem 'coveralls', '~> 0.7'
end

group :debugging do
  # A REPL like IRB, but much better.
  gem 'pry', '~> 0.9'

  # Don't leave home without a debugger!
  gem 'debugger', '~> 1.6', :platforms => :mri

  # Or Rubinius' debugging tools
  gem 'rubinius-developer_tools', '~> 2.0', :platforms => :rbx
end

group :guard do
  # A generic file system event handler; spin it up and see the tests fly.
  gem 'guard', '~> 2.2'

  # Guard configuration to reload when the gem bundle changes
  gem 'guard-bundler', '~> 2.0'

  # Guard configuration to manage our spork drb environments.
  gem 'guard-spork', '~> 1.5'

  # Guard configuration & hooks for rspec.
  gem 'guard-rspec', '~> 4.2'

  # File system event hooks for OS X.
  gem 'rb-fsevent', '~> 0.9'

  # File system event hooks for Linux.
  gem 'rb-inotify', '~> 0.9'

  # File system event hooks for Windows.
  gem 'rb-fchange', '~> 0.0'

  # OS X 10.8+ notification center support.
  gem 'terminal-notifier-guard', '~> 1.5'

  # libnotify bindings (Linux).
  gem 'libnotify', '~> 0.8'

  # notifu adapter (Windows).
  gem 'rb-notifu', '~> 0.0'
end

platforms :ruby_18 do
  # rest-client (via coveralls) has an unbounded requirement on mime-types.
  gem 'mime-types', '~> 1.25'
end

platforms :ruby_19, :ruby_20 do
  group :test do
      # Style enforcement & linting.
    gem 'rubocop', '~> 0.18'

    # RSpec style enforcement & linting.
    gem 'rubocop-rspec', '~> 0.18'
  end

  group :guard do
    # Guard configuration for rubocop style & lint checks.
    gem 'guard-rubocop', '~> 1.0'
  end
end

platforms :ruby_20, :ruby_21 do
  # The preferred code mutation library.
  gem 'mutant', '~> 0.3'
end

platforms :rbx do
  # The Ruby standard library.
  gem 'rubysl', '~> 2.0'

  # YAML support for Rubinius.
  gem 'psych', '~> 2.0'
end
