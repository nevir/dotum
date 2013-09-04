# encoding: utf-8

describe Dotum::Util::Path, "#link_path" do
  include_context "path fixtures"

  it "should expand the target path of a relative symlink" do
    expect(described_class.new(symlink_fixture).link_path).to eq(file_fixture)
  end

  it "should return a Path" do
    expect(described_class.new(symlink_fixture).link_path).to be_a(described_class)
  end

  it "should raise EINVAL for a file" do
    expect { described_class.new(file_fixture).link_path }.to raise_error(Errno::EINVAL)
  end

  it "should raise EINVAL for a directory" do
    expect { described_class.new(directory_fixture).link_path }.to raise_error(Errno::EINVAL)
  end

  it "should raise ENOENT for a non-entity" do
    expect { described_class.new(non_fixture).link_path }.to raise_error(Errno::ENOENT)
  end

end
