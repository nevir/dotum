describe Dotum::RuleOptionsDSL, '#expand_shorthand' do
  include_context 'options DSL'

  context 'with positional options' do

    before(:each) do
      base_class.class_eval do
        shorthand :foo, :bar
      end
    end

    it 'should expand positional arguments' do
      expect(base_class.expand_shorthand(1, 2)).to eq({:foo => 1, :bar => 2})
    end

    it 'should ignore missing positional arguments' do
      expect(base_class.expand_shorthand(1)).to eq({:foo => 1})
    end

  end

  context 'with hash options' do

    before(:each) do
      base_class.class_eval do
        shorthand :fizz => :buzz
      end
    end

    it 'should expand hash arguments' do
      expect(base_class.expand_shorthand('one' => 'two')).to eq({:fizz => 'one', :buzz => 'two'})
    end

    it 'should expand a positional argument for hash spec to the key' do
      expect(base_class.expand_shorthand('hello')).to eq({:fizz => 'hello'})
    end

  end

  context 'with positional and hash options' do

    before(:each) do
      base_class.class_eval do
        shorthand :a, :b, :c => :d
      end
    end

    it 'should support positional and hash arguments together' do
      expect(base_class.expand_shorthand(1, 2, 3 => 4)).to eq({:a => 1, :b => 2, :c => 3, :d => 4})
    end

  end

end
