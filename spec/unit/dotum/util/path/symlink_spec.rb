describe Dotum::Util::Path, "#symlink?" do
  include_context "path fixtures"

  it "should be false for files" do
    expect(described_class.new(file_fixture).symlink?).to be_false
  end

  it "should be false for directories" do
    expect(described_class.new(directory_fixture).symlink?).to be_false
  end

  it "should be true for symlinks" do
    expect(described_class.new(symlink_fixture).symlink?).to be_true
  end

  it "should be false for non-entities" do
    expect(described_class.new(non_fixture).symlink?).to be_false
  end

end
