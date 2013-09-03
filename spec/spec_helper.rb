# encoding: utf-8

begin
  require "spork"
  require "spork/ext/ruby-debug"
rescue LoadError
  # No spork? No problem!
  module Spork
    def self.prefork
      yield
    end

    def self.each_run
      yield
    end
  end
end

Spork.prefork do
  # Allow requires relative to the spec dir
  SPEC_ROOT    = File.expand_path("..", __FILE__)
  FIXTURE_ROOT = File.join(SPEC_ROOT, "fixtures")
  $LOAD_PATH << SPEC_ROOT

  require "rspec"
  require "timeout"

  # Load our spec environment (random to avoid dependency ordering)
  Dir[File.join(SPEC_ROOT, "common", "*.rb")].shuffle.each do |helper|
    require "common/#{File.basename(helper, ".rb")}"
  end

  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true

    # We enforce expect(...) style syntax to avoid mucking around in Core
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end

    # Time out specs (particularly useful for mutant)
    config.around(:each) do |spec|
      timeout(0.5) { spec.run }
    end

    # Be verbose about warnings
    config.around(:each) do |spec|
      old_verbose = $VERBOSE
      # Or not at all if we are mutation testing
      $VERBOSE = ENV["MUTATION"] ? nil : 2

      spec.run

      $VERBOSE = old_verbose
    end
  end
end

Spork.each_run do
  # The rspec test runner executes the specs in a separate process; plus it's nice to have this
  # generic flag for cases where you want coverage running with guard.
  if ENV["COVERAGE"]
    require "simplecov"

    if ENV["CONTINUOUS_INTEGRATION"]
      require "coveralls"
      Coveralls.wear!
    end
  end

  # Because we're an autoloading lib, just require the root up front.
  #
  # Must be loaded _after_ `simplecov`, otherwise it won't pick up on requires.
  require "dotum"
end

