describe Dotum::Util::Path, '#basename' do

  it 'should return the file name of a path' do
    expect(described_class.new('foo').basename).to eq('foo')
  end

end
