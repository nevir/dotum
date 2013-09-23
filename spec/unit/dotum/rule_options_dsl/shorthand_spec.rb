describe Dotum::RuleOptionsDSL, "#preprocessor_methods" do
  include_context "options DSL"

  it "should set shorthand_config" do
    base_class.class_eval do
      shorthand :foo
    end

    expect(base_class.shorthand_config).to eq([:foo])
  end

end
