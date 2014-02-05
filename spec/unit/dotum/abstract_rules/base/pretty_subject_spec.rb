describe Dotum::AbstractRules::Base, '#pretty_subject' do
  include_context 'rule class helpers'

  subject do
    new_rule_class(:SomeRule).new(Dotum::Context.new)
  end

  it 'should be abstract' do
    expect { subject.pretty_subject }.to raise_error(
      NotImplementedError, /pretty_subject/
    )
  end

end
