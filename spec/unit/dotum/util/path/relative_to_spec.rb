# encoding: utf-8

describe Dotum::Util::Path, "#relative_to" do

  it "should chop off common ancestry" do
    source = described_class.new("a/b/c")
    target = described_class.new("a/b/c/d/e")

    expect(target.relative_to(source)).to eq(File.join("d", "e"))
  end

  it "should use '..' for differing parent directories" do
    source = described_class.new("a/b/c")
    target = described_class.new("a/d/e/f")

    expect(target.relative_to(source)).to eq(File.join("..", "..", "d", "e", "f"))
  end

  it "should use '.' for the same path" do
    source = described_class.new("a/b/c")
    target = described_class.new("a/b/c")

    expect(target.relative_to(source)).to eq(".")
  end

  it "should use '.' for the same path" do
    source = described_class.new("a/b/c")
    target = described_class.new("a/b/c")

    expect(target.relative_to(source)).to eq(".")
  end

end
