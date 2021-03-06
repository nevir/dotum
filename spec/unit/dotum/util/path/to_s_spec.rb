describe Dotum::Util::Path, '#to_s' do

  it 'should return the string form of the path' do
    value = described_class.new('foo').to_s
    expect(value).to eq(File.join(Dir.pwd, 'foo'))
    expect(value).to be_a(String)
  end

end
