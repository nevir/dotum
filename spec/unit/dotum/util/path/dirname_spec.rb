# encoding: utf-8

describe Dotum::Util::Path, "#dirname" do

  it "should return the directory name of a path" do
    expect(described_class.new("foo").dirname).to eq(Dir.pwd)
  end

  it "should return a Path" do
    expect(described_class.new("foo").dirname).to be_a(described_class)
  end

end
