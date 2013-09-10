# encoding: utf-8

namespace :spec do

  SPEC_TARGET_MATCHER = /^describe\s+(Dotum::[:\w]+)(?:,\s*"([^"]+)")?/

  desc "Runs tests with code mutation"
  task :mutate, [:focus_on] do |t, args|
    # Skip known bad implementations for now.
    unless mutant_supported?
      $stdout.puts "Mutant isn't supported (or tested) on this Ruby implementation."
      next
    end

    if args.focus_on
      matchers = matcher_for_focus(args.focus_on)
    else
      matchers = all_matchers
    end

    ENV["MUTATION"] = "yes"
    status = Mutant::CLI.run(["--rspec"] + matchers)
    ENV["MUTATION"] = nil

    # Don't fail the build until we get to the bottom of https://github.com/mbj/mutant/issues/106
    # raise "Mutation failed." if status > 0
  end

  def matcher_for_focus(focus)
    # Method on Dotum?
    if focus.start_with?(".") || focus.start_with?("#")
      return ["::Dotum#{focus}"]
    # Or regular constant?
    else
      return ["::Dotum::#{focus}"]
    end
  end

  def all_matchers
    # We can't just take a path and re-capitalize it.  It might be an acronym,
    # like ANSIColors.
    Dir["spec/unit/**/*_spec.rb"].map { |spec_path|
      File.open(spec_path) do |spec_file|
        spec_target(spec_file)
      end
    }.compact
  end

  def spec_target(spec_file)
    spec_file.each_line do |line|
      if match = SPEC_TARGET_MATCHER.match(line)
        return "::#{match[1]}#{match[2]}"
      end

      return nil if spec_file.lineno > 10
    end
  end

  def mutant_supported?
    # uninitialized constant Mutant::Strategy::Rspec::StringIO
    return false if RUBY_VERSION.start_with?("1.9.2")
    # ambiguous option: --rspec
    return false if defined?(RUBY_ENGINE) && RUBY_ENGINE == "rbx"

    begin
      require "mutant"
    rescue LoadError => err
      $stderr.puts "Failed to load mutant: #{err}"
      return false
    end

    true
  end

end
