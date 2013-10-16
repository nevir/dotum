describe Dotum::RuleOptionsDSL, '#eval_options_block' do
  include_context 'options DSL'

  before(:each) do
    base_class.class_eval do
      optional :foo
      optional :bar, 123
    end
  end

  it 'should return the evaluated options' do
    options = base_class.eval_options_block do
      foo 'foo!'
      bar 'bar!'
    end

    expect(options).to eq({:foo => 'foo!', :bar => 'bar!'})
  end

  it 'should only accept defined options' do
    expect {
      base_class.eval_options_block do
        not_an_option :hi
      end
    }.to raise_error
  end

end
