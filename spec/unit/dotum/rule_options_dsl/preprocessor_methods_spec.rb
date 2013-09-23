describe Dotum::RuleOptionsDSL, "#preprocessor_methods" do
  include_context "options DSL"

  context "with registered preprocessors" do

    before(:each) do
      base_class.class_eval do
        register_preprocessor(:do_stuff)
        register_preprocessor(:shared)
      end

      child_class.class_eval do
        register_preprocessor(:do_things)
        register_preprocessor(:shared)
      end
    end

    it "should propagate preprocessor methods to children" do
      expect(child_class.preprocessor_methods).to match_array([:do_stuff, :do_things, :shared])
    end

  end

  context "without registered preprocessors" do

    it "should return an empty set if nothing is registered" do
      expect(base_class.preprocessor_methods).to eq([])
    end

  end

end
