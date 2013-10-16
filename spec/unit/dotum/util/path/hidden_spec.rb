describe Dotum::Util::Path, '#hidden?' do

  it 'should treat dotfiles as hidden' do
    expect(described_class.new('.foo').hidden?).to be_true
  end

  it 'should treat dot directories as hidden' do
    expect(described_class.new('.foo', 'bar').hidden?).to be_true
  end

  it 'should not treat regular files as hidden' do
    expect(described_class.new('thing').hidden?).to be_false
  end

end
