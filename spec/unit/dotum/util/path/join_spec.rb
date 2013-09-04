# encoding: utf-8

describe Dotum::Util::Path, "#join" do

  subject {
    described_class.new("base")
  }

  it "should append components" do
    expect(subject.join("one")).to eq(File.join(Dir.pwd, "base", "one"))
    expect(subject.join("one", "two")).to eq(File.join(Dir.pwd, "base", "one", "two"))
  end

  it "should expand components" do
    expect(subject.join("a/b\\c")).to eq(File.join(Dir.pwd, "base", "a", "b", "c"))
  end

  it "should return a new Path" do
    expect(subject.join("foo")).to be_a(described_class)
    expect(subject.join("/foo")).to be_a(described_class)
    expect(subject.join("C:\\foo")).to be_a(described_class)
  end

  it "should support joining other Paths" do
    expect(subject.join(described_class.new("~/thing"))).to eq(File.join(ENV["HOME"], "thing"))
  end


  # Unix
  # ----
  if File::Separator == "/"

    it "should defer to absolute paths" do
      expect(subject.join("/hi")).to eq("/hi")
    end

    it "should expand from the last absolute path given" do
      expect(subject.join("a", "/b", "c", "/d", "e")).to eq("/d/e")
    end


  # Windows
  # -------
  elsif File::Separator == "\\"

    it "should defer to absolute paths" do
      expect(subject.join("C:\\foo")).to eq("C:\\hi")
    end


    it "should expand from the last absolute path given" do
      expect(subject.join("a", "B:\\c", "d", "E:\\f", "g")).to eq("E:\\f\\g")
    end


  # Unknown!
  # --------
  else
   raise "Unknown file separator #{File::Separator}!"
  end

end
