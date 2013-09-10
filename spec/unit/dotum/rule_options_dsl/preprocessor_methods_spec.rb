# encoding: utf-8

describe Dotum::RuleOptionsDSL, "#preprocessor_methods" do
  include_context "options DSL"

  it "should propagate preprocessor methods to children" do
    base_class.class_eval do
      register_preprocessor(:do_stuff)
      register_preprocessor(:shared)
    end

    child_class.class_eval do
      register_preprocessor(:do_things)
      register_preprocessor(:shared)
    end

    expect(child_class.preprocessor_methods).to match_array([:do_stuff, :do_things, :shared])
  end

  it "should return an empty set if nothing is registered" do
    expect(base_class.preprocessor_methods).to eq([])
  end

end
