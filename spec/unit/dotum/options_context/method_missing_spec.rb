describe Dotum::OptionsContext, "#method_missing" do

  subject {
    described_class.new({
      :one => Dotum::RuleOptionsDSL::OptionConfig.new,
      :two => Dotum::RuleOptionsDSL::OptionConfig.new,
    });
  }

  it "should expose a setter when called w/ one argument" do
    subject.one(:hi)
    expect(subject[:one]).to eq(:hi)
  end

  it "should freak out if you call w/o arguments" do
    expect { subject.one }.to raise_error(NameError)
  end

  it "should freak out if you try to set a non-option" do
    expect { subject.three(123) }.to raise_error(NameError, /three/)
  end

end
