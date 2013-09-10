shared_context "options DSL" do

  let(:base_class) {
    Class.new.tap do |klass|
      klass.send(:extend, described_class)
    end
  }

  let(:child_class) {
    Class.new(base_class)
  }

end
