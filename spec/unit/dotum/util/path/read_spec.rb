describe Dotum::Util::Path, '#read' do
  include_context 'path fixtures'

  it 'should return contents of a file' do
    expect(described_class.new(file_fixture).read).to eq("Lorem ipsum.\n")
  end

  it 'should return contents of a symlink' do
    expect(described_class.new(symlink_fixture).read).to eq("Lorem ipsum.\n")
  end

  it 'should raise EISDIR when reading a directory' do
    expect { described_class.new(directory_fixture).read }.to raise_error(Errno::EISDIR)
  end

  it 'should raise ENOENT when reading a non-entity' do
    expect { described_class.new(non_fixture).read }.to raise_error(Errno::ENOENT)
  end

end
