# encoding: utf-8

describe Dotum::RuleOptionsDSL, "#validate_options" do
  include_context "options DSL"

  before(:each) do
    base_class.class_eval do
      optional :foo
    end

    child_class.class_eval do
      required :foo
      required :bar
    end
  end

  it "should return nil for no errors" do
    expect(base_class.validate_options({})).to be_nil
    expect(child_class.validate_options({:foo => 1, :bar => 2})).to be_nil
  end

  it "should validate required options" do
    expect(child_class.validate_options({})).to match_array([
      "Option 'foo' is required.",
      "Option 'bar' is required."
    ])
    expect(child_class.validate_options({:foo => 3})).to match_array([
      "Option 'bar' is required."
    ])
  end

end
