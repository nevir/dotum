describe Dotum::RuleOptionsDSL, "#shorthand_config" do
  include_context "options DSL"

  it "should inherit a shorthand from its parent" do
    base_class.class_eval do
      shorthand :base, :shorthand
    end

    expect(child_class.shorthand_config).to match_array([:base, :shorthand])
  end

  it "should override values from its parent" do
    base_class.class_eval do
      shorthand :base, :shorthand
    end

    child_class.class_eval do
      shorthand :child
    end

    expect(child_class.shorthand_config).to match_array([:child])
    expect(base_class.shorthand_config).to match_array([:base, :shorthand])
  end

  it "should return an empty config if nothing is registered" do
    expect(base_class.shorthand_config).to eq([])
  end

end
