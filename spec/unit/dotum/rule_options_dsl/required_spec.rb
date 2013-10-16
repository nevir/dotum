describe Dotum::RuleOptionsDSL, '#required' do
  include_context 'options DSL'

  before(:each) do
    base_class.class_eval do
      required :foo
    end
  end

  it 'should register an option' do
    expect(base_class.option_configs).to have_key(:foo)
  end

  it 'should generate a validation error if the value is missing' do
    expect(base_class.validate_options({})).to eq(["Option 'foo' is required."])
  end

end
