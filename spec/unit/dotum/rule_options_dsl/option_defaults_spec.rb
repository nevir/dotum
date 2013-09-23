describe Dotum::RuleOptionsDSL, "#option_defaults" do
  include_context "options DSL"

  context "with options" do

    before(:each) do
      base_class.class_eval do
        optional :bar, 123
        optional :baz, :moo
      end
    end

    it "should return defaults for those options that define them" do
      expect(base_class.option_defaults).to eq({:bar => 123, :baz => :moo})
    end

    it "should inherit options from parent classes" do
      expect(child_class.option_defaults).to eq({:bar => 123, :baz => :moo})
    end

  end

  context "with inherited options" do

    before(:each) do
      base_class.class_eval do
        optional :foo
        optional :bar, 123
        optional :baz, :moo
      end

      child_class.class_eval do
        optional :baz, :foo
        optional :one, 1
      end
    end

    it "should merge and override inherited options" do
      expect(child_class.option_defaults).to eq({:bar => 123, :baz => :foo, :one => 1})
    end

  end

  context "without options" do

    it "should return an empty set of defaults" do
      expect(base_class.option_defaults).to eq({})
    end

  end

end
