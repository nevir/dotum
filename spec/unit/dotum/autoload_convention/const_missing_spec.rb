describe Dotum::AutoloadConvention, "#const_missing" do

  let(:namespace) {
    mod = Module.new do
      class << self
        def name
          "Fixtures::AutoloadConvention"
        end
        alias_method :inspect, :name
      end
    end
    mod.extend subject

    mod
  }

  it "should raise a LoadError when referencing an unknown constant" do
    expect { namespace::Foo }.to raise_error(LoadError)
  end

  it "should raise a NameError when the file exists, but the wrong constant is defined" do
    expect { namespace::Mismatched }.to raise_error(NameError)
  end

  it "should load single-token files" do
    namespace.should_receive(:require).with("fixtures/autoload_convention/single").and_call_original

    expect(namespace::Single).to eq(:single_and_stuff)
  end

  it "should load multi-token files" do
    namespace.should_receive(:require).with("fixtures/autoload_convention/multi_token").and_call_original

    expect(namespace::MultiToken).to eq(:multi)
  end

  it "shouldn't split ACRONYMS" do
    namespace.should_receive(:require).with("fixtures/autoload_convention/allcaps").and_call_original

    expect(namespace::ALLCAPS).to eq(:yelling)
  end

  it "should split ACRONYMSEndingWithRegularNames" do
    namespace.should_receive(:require).with("fixtures/autoload_convention/abc_one_two_three").and_call_original

    expect(namespace::ABCOneTwoThree).to eq(:you_can_count!)
  end

  it "shouldn't pick up constants in parent namespaces" do
    namespace.should_receive(:require).with("fixtures/autoload_convention/string").and_call_original

    expect(namespace::String).to eq("I am a string!")
  end

end
