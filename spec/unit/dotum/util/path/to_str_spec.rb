# encoding: utf-8

describe Dotum::Util::Path, "#to_str" do

  it "should return the string form of the path" do
    value = described_class.new("foo").to_str
    expect(value).to eq(File.join(Dir.pwd, "foo"))
    expect(value).to be_a(String)
  end

end
