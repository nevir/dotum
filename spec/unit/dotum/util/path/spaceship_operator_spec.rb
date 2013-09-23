describe Dotum::Util::Path, "#<=>" do

  subject { described_class.new("b") }

  it "should be Comparable" do
    expect(described_class.included_modules).to include(Comparable)
  end

  it "should support equality" do
    expect(described_class.new("asdf") <=> described_class.new("asdf")).to eq(0)
  end

  it "should support sorted comparisons" do
    expect(described_class.new("a") <=> described_class.new("b")).to eq(-1)
    expect(described_class.new("b") <=> described_class.new("a")).to eq(1)
  end

  it "should support comparisons with strings" do
    expect(subject <=> File.join(Dir.pwd, "a")).to eq(1)
    expect(subject <=> File.join(Dir.pwd, "b")).to eq(0)
    expect(subject <=> File.join(Dir.pwd, "c")).to eq(-1)
  end

  it "should be comparable by strings" do
    expect(File.join(Dir.pwd, "a") <=> subject).to eq(-1)
    expect(File.join(Dir.pwd, "b") <=> subject).to eq(0)
    expect(File.join(Dir.pwd, "c") <=> subject).to eq(1)
  end

  it "should be comparable with stringable objects" do
    obj = Object.new
    class << obj
      def to_str
        File.join(Dir.pwd, "b")
      end
    end

    expect(subject <=> obj).to eq(0)
  end

end
