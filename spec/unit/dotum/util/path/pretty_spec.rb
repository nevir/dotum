describe Dotum::Util::Path, '#pretty' do

  it 'should collapse paths referencing the home dir' do
    expect(described_class.new(ENV['HOME']).join('one').pretty).to eq('~/one')
  end

  it 'should return full paths as fallback' do
    expect(described_class.new('/foo/bar').pretty).to eq('/foo/bar')
  end

  it 'should return a string' do
    expect(described_class.new('thing').pretty).to be_a(String)
  end

  # Unix
  # ----
  if File::Separator == '/'

    it 'should return full paths as fallback' do
      expect(described_class.new('/foo/bar').pretty).to eq('/foo/bar')
    end

  # Windows
  # -------
  elsif File::Separator == '\\'

    it 'should return full paths as fallback' do
      expect(described_class.new('C:\\foo\\bar').pretty).to eq('C:\\foo\\bar')
    end

  # Unknown!
  # --------
  else
    fail "Unknown file separator #{File::Separator}!"
  end

end
