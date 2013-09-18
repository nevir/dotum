# encoding: utf-8

describe Dotum::RuleOptionsDSL, "#expand_shorthand" do
  include_context "options DSL"

  it "should expand positional arguments" do
    base_class.class_eval do
      shorthand :foo, :bar
    end

    expect(base_class.expand_shorthand(1, 2)).to eq({:foo => 1, :bar => 2})
  end

  it "should ignore missing positional arguments" do
    base_class.class_eval do
      shorthand :foo, :bar
    end

    expect(base_class.expand_shorthand(1)).to eq({:foo => 1})
  end

  it "should expand hash arguments" do
    base_class.class_eval do
      shorthand :fizz => :buzz
    end

    expect(base_class.expand_shorthand("one" => "two")).to eq({:fizz => "one", :buzz => "two"})
  end

  it "should expand a positional argument for hash spec to the key" do
    base_class.class_eval do
      shorthand :fizz => :buzz
    end

    expect(base_class.expand_shorthand("hello")).to eq({:fizz => "hello"})
  end

  it "should support positional and hash arguments together" do
    base_class.class_eval do
      shorthand :a, :b, :c => :d
    end

    expect(base_class.expand_shorthand(1, 2, 3 => 4)).to eq({:a => 1, :b => 2, :c => 3, :d => 4})
  end

end
