describe Dotum::AbstractRules::Base, '.pretty' do
  include_context 'rule class helpers'

  it 'should lowercase single words in the class base name' do
    expect(new_rule_class(:Pretty).pretty).to eq('pretty')
  end

  it 'should snake_case MultiWordNames' do
    expect(new_rule_class(:CamelCaps).pretty).to eq('camel_caps')
  end

  it 'should not split ACRONYMS' do
    expect(new_rule_class(:ABCD).pretty).to eq('abcd')
  end

  it 'should split on acronym boundaries' do
    expect(new_rule_class(:ABCOneTwoThree).pretty).to eq('abc_one_two_three')
  end

  it 'should memoize' do
    klass = new_rule_class(:CamelCaps)
    klass.pretty

    # https://github.com/mbj/mutant/issues/150
    expect(klass.instance_variable_get(:@pretty)).to eq('camel_caps')
  end

end
