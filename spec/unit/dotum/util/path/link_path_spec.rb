# encoding: utf-8

describe Dotum::Util::Path, "#link_path" do
  include_context "path fixtures"

  it "should return the target path of an absolute symlink" do
    expect(described_class.new(abs_symlink_fixture).link_path).to eq("/abs/path")
  end

  it "should expand the target path of a relative symlink" do
    expect(described_class.new(symlink_fixture).link_path).to eq(file_fixture)
  end

  it "should return a Path" do
    expect(described_class.new(symlink_fixture).link_path).to be_a(described_class)
  end

  it "should raise EINVAL for a non-symlink" do
    expect { described_class.new(file_fixture).link_path }.to raise_error(Errno::EINVAL)
  end

end
