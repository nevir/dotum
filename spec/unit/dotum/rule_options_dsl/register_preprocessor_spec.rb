describe Dotum::RuleOptionsDSL, "#register_preprocessor" do
  include_context "options DSL"

  it "should register a preprocessor" do
    base_class.class_eval do
      register_preprocessor(:do_stuff)
    end

    expect(base_class.preprocessor_methods).to eq([:do_stuff])
  end

end
