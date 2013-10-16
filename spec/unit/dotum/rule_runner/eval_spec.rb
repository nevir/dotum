describe Dotum::RuleRunner, '.eval' do

  it "should return the result of the eval'd block" do
    expect(described_class.eval(nil) { 123 }).to eq(123)
  end

  it 'should run the block in an instance of its self' do
    obj = described_class.eval(nil) { self }
    expect(obj).to be_a(described_class)
  end

  it 'should set the context' do
    expect(described_class.eval(:context) { context }).to eq(:context)
  end

  it 'should support string-based eval, too' do
    begin
      described_class.eval(nil, "raise 'foo'", 'FILE', 123)
    rescue RuntimeError => error
      expect(error.backtrace.first).to match(/FILE:123.*eval/)
    end
  end

end
