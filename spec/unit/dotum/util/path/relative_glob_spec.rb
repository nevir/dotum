describe Dotum::Util::Path, "#relative_glob" do
  include_context "path fixtures"

  subject { described_class.new(directory_fixture) }

  it "should return an empty array for no matches" do
    expect(subject.glob("not/a/single/match")).to eq([])
  end

  it "should support * globs" do
    expect(subject.relative_glob("*")).to match_array(["one", "two", "three", "foo", ".hidden", "sub"])
  end

  it "should support **/* globs" do
    expect(subject.relative_glob("**/*")).to match_array([
      "one", "two", "three", "foo", ".hidden", "sub", "sub/four", "sub/five", "sub/six"
    ])
  end

  it "should support filtered ** globs" do
    expect(subject.relative_glob("**/f*")).to match_array(["foo", "sub/four", "sub/five"])
  end

  it "should support filtering by path" do
    expect(subject.relative_glob("*", &:file?)).to match_array(["one", "two", "three", "foo", ".hidden"])
  end

  it "should return Strings" do
    expect(subject.relative_glob("*").map(&:class).uniq).to eq([String])
  end

  it "should use dot notation for paths that match up the tree" do
    expect(subject.relative_glob("../*")).to match_array([".", "../file", "../symlink"])
  end

end
