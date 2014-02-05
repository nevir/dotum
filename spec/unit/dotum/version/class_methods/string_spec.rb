describe Dotum::Version, '.string' do

  it 'should be a valid version' do
    expect(described_class.string).to match(/^\d+\.\d+\.\d+$/)
  end

end
