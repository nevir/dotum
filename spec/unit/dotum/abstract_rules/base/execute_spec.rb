describe Dotum::AbstractRules::Base, '#execute' do
  include_context 'rule class helpers'

  subject do
    new_rule_class(:SomeRule).new(Dotum::Context.new)
  end

  it 'should be abstract' do
    expect { subject.exec }.to raise_error(
      NotImplementedError, /execute/
    )
  end

end
