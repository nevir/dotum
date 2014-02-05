describe Dotum::AbstractRules::Base, '.pretty' do

  def new_class(name)
    scope = Module.new
    scope.module_eval <<-end_module, __FILE__, __LINE__
      class #{name} < #{described_class}; end
    end_module

    scope.const_get(name)
  end

  it 'should lowercase single words in the class base name' do
    expect(new_class(:Pretty).pretty).to eq('pretty')
  end

  it 'should snake_case MultiWordNames' do
    expect(new_class(:CamelCaps).pretty).to eq('camel_caps')
  end

  it 'should not split ACRONYMS' do
    expect(new_class(:ABCD).pretty).to eq('abcd')
  end

  it 'should split on acronym boundaries' do
    expect(new_class(:ABCOneTwoThree).pretty).to eq('abc_one_two_three')
  end

  it 'should memoize' do
    klass = new_class(:CamelCaps)
    klass.pretty

    # https://github.com/mbj/mutant/issues/150
    expect(klass.instance_variable_get(:@pretty)).to eq('camel_caps')
  end

end
