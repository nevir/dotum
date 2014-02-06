module RuleClassHelpers; end
module RuleClassHelpers::Scope; end

shared_context 'rule class helpers' do
  def new_rule_class(name)
    RuleClassHelpers::Scope.const_set(name, Class.new(described_class))
  end

  after(:each) do
    RuleClassHelpers::Scope.constants.each do |const|
      RuleClassHelpers::Scope.send(:remove_const, const)
    end
  end
end
