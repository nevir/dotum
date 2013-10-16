describe Dotum::RuleOptionsDSL, '#optional' do
  include_context 'options DSL'

  before(:each) do
    base_class.class_eval do
      optional :foo
      optional :bar, 123
    end
  end

  it 'should register an option' do
    expect(base_class.option_configs).to have_key(:foo)
  end

  it 'should support default values' do
    expect(base_class.option_defaults).to eq({:bar => 123})
  end

  it 'should not generate a validation error if the value is missing' do
    expect(base_class.validate_options({})).to be_nil
  end

end
