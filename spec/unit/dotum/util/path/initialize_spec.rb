# encoding: utf-8

describe Dotum::Util::Path, "#initialize" do

  it "should normalize separators" do
    expect(described_class.new("one/two")).to eq(File.join(Dir.pwd, "one", "two"))
    expect(described_class.new("one\\two")).to eq(File.join(Dir.pwd, "one", "two"))
    expect(described_class.new("a\\b/c\\d/e")).to eq(
      File.join(Dir.pwd, "a", "b", "c", "d", "e")
    )
  end

  it "should expand the given path" do
    expect(described_class.new("")).to eq(Dir.pwd)
    expect(described_class.new("~")).to eq(ENV["HOME"])
    expect(described_class.new("foo/bar")).to eq(File.join(Dir.pwd, "foo", "bar"))
  end

  it "should accept other Paths" do
    other = described_class.new("thing")
    expect(described_class.new(other)).to eq(other)
  end

  it "should support explicit relative paths" do
    expect(described_class.new("foo", "bar")).to eq(File.join(Dir.pwd, "bar", "foo"))
  end

end
