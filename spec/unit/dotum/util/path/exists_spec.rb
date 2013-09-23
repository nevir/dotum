describe Dotum::Util::Path, "#exists?" do
  include_context "path fixtures"

  it "should be true for files" do
    expect(described_class.new(file_fixture).exists?).to be_true
  end

  it "should be true for directories" do
    expect(described_class.new(directory_fixture).exists?).to be_true
  end

  it "should be true for symlinks" do
    expect(described_class.new(symlink_fixture).exists?).to be_true
  end

  it "should be false for non-entities" do
    expect(described_class.new(non_fixture).exists?).to be_false
  end

end
