# encoding: utf-8

describe Dotum::RuleOptionsDSL, "#standard" do
  include_context "options DSL"

  describe "properly defined" do

    before(:each) do
      module Dotum::StandardOptions::FooForTest
        extend Dotum::RuleOptionsDSL

        required(:foo_for_test) { |v| v + 1 }
      end

      base_class.class_eval do
        standard :foo_for_test
      end
    end

    after(:each) do
      Dotum::StandardOptions.send(:remove_const, :FooForTest)
    end

    it "should properly reference a standard option" do
      expect(base_class.option_configs).to have_key(:foo_for_test)
    end

    it "should respect the standard option's configuraton" do
      options = base_class.process_options({:foo_for_test => 3})
      expect(options).to eq({:foo_for_test => 4})
    end

  end

  it "should raise a LoadError for undefined standard options" do
    expect {
      base_class.class_eval do
        standard :missing_option
      end
    }.to raise_error(ArgumentError, "Unknown standard option 'missing_option'.  Tried to load Dotum::StandardOptions::MissingOption: cannot load such file -- dotum/standard_options/missing_option.rb")
  end

  it "should raise a LoadError for modules that define the wrong option" do
    begin
      module Dotum::StandardOptions::SomeOption
        extend Dotum::RuleOptionsDSL
        optional :wrong_name
      end

      expect {
        base_class.class_eval do
          standard :some_option
        end
      }.to raise_error("Dotum::StandardOptions::SomeOption is misconfigured; expected it to define the option 'some_option'")
    ensure
      Dotum::StandardOptions.send(:remove_const, :SomeOption)
    end
  end

  it "should raise a LoadError for modules that don't define any options" do
    begin
      module Dotum::StandardOptions::SomeOption
        extend Dotum::RuleOptionsDSL
      end

      expect {
        base_class.class_eval do
          standard :some_option
        end
      }.to raise_error("Dotum::StandardOptions::SomeOption is misconfigured; expected it to define the option 'some_option'")
    ensure
      Dotum::StandardOptions.send(:remove_const, :SomeOption)
    end
  end

end
