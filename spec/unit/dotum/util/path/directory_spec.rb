describe Dotum::Util::Path, '#directory?' do
  include_context 'path fixtures'

  it 'should be false for files' do
    expect(described_class.new(file_fixture).directory?).to be_false
  end

  it 'should be true for directories' do
    expect(described_class.new(directory_fixture).directory?).to be_true
  end

  it 'should be false for symlinks' do
    expect(described_class.new(symlink_fixture).directory?).to be_false
  end

  it 'should be false for non-entities' do
    expect(described_class.new(non_fixture).directory?).to be_false
  end

end
