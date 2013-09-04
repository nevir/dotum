# encoding: utf-8

describe Dotum::Util::Path, "#file?" do
  include_context "path fixtures"

  it "should be true for files" do
    expect(described_class.new(file_fixture).file?).to be_true
  end

  it "should be false for directories" do
    expect(described_class.new(directory_fixture).file?).to be_false
  end

  it "should be true for symlinks" do
    expect(described_class.new(symlink_fixture).file?).to be_true
  end

  it "should be false for non-entities" do
    expect(described_class.new(non_fixture).file?).to be_false
  end

end
