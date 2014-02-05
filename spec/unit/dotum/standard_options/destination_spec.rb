describe Dotum::StandardOptions::Destination do
  include_context 'simple rule'

  it 'should be required' do
    rule_class.exec(context, {})
  end

end
