describe Dotum::RuleOptionsDSL, "#process_options" do
  include_context "options DSL"

  let(:context) {
    Object.new.tap do |context|
      def context.thing
        123
      end
    end
  }

  context "with filters" do

    before(:each) do
      base_class.class_eval do
        required(:foo) { |*args| args }
        optional(:bar) { |v| v + (defined?(thing) ? thing : 2) }
      end
    end

    it "should execute filters without a context" do
      expect(base_class.process_options({:foo => :a, :bar => 1})).to eq({:foo => [:a], :bar => 3})
    end

    it "should execute filters with a context" do
      expect(base_class.process_options({:foo => :a, :bar => 1}, context)).to eq(
        {:foo => [:a], :bar => 124}
      )
    end

    it "should skip nil values" do
      expect(base_class.process_options({:foo => :a, :bar => nil}, context)).to eq(
        {:foo => [:a], :bar => nil}
      )
    end

    it "should not modify the input" do
      input = {:foo => :a, :bar => 1}
      base_class.process_options(input)

      expect(input).to eq({:foo => :a, :bar => 1})
    end

  end

  context "without filters" do

    it "should no-op without a context" do
      expect(base_class.process_options({:a => 1, :b => :c})).to eq({:a => 1, :b => :c})
    end

    it "should no-op with a context" do
      expect(base_class.process_options({:a => 1}, context)).to eq({:a => 1})
    end

  end

end
