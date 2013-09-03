# encoding: utf-8

namespace :spec do

  SPEC_TARGET_MATCHER = /^describe\s+(Dotum::[:\w]+)/

  desc "Runs tests with code mutation"
  task :mutate, [:focus_on] do |t, args|
    begin
      require "mutant"
    rescue LoadError
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

    raise "Mutation failed." if status > 0
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
    }
  end

  def spec_target(spec_file)
    spec_file.each_line do |line|
      if match = SPEC_TARGET_MATCHER.match(line)
        return "::#{match[1]}"
      end
    end
  end

end
