describe Dotum::RuleRunner do

  it 'should include the rule DSL' do
    expect(described_class.included_modules).to include(Dotum::RuleDSL)
  end

end
