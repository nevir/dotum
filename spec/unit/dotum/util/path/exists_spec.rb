# encoding: utf-8

describe Dotum::Util::Path, "#exists?" do

  it "should be true for files" do
    expect(described_class.new(__FILE__)).to exist
  end

  it "should be true for directories" do
    expect(described_class.new(File.dirname(__FILE__))).to exist
  end

  it "should be false for non-entities" do
    expect(described_class.new(File.join(__FILE__, "nope"))).to_not exist
  end

end
