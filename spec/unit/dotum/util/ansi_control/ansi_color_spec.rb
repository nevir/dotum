describe Dotum::Util::ANSIControl, '#ansi_color' do

  subject do
    Object.new.tap do |object|
      (class << object; self; end).send(:include, described_class)
    end
  end

  it 'should return an escaped color' do
    expect(subject.ansi_color('heyo', '30')).to eq("\e[30mheyo\e[0m")
    expect(subject.ansi_color('hi', '37;1')).to eq("\e[37;1mhi\e[0m")
  end

  it 'should define helpers for all colors' do
    color_methods  = described_class::COLORS.map { |c| :"c_#{c}" }
    color_methods += described_class::COLORS.map { |c| :"c_bright_#{c}" }
    all_methods    = described_class.instance_methods.map(&:to_sym)

    expect(all_methods & color_methods).to match_array(color_methods)
  end

  it 'should allow for overrides to `ansi_color`' do
    def subject.ansi_color(text, code)
      "#{text}-#{code}"
    end

    expect(subject.c_bright_red('stuff')).to eq('stuff-31;1')
  end

end
