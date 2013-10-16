shared_context 'options DSL' do

  let(:base_class) do
    Class.new.tap do |klass|
      klass.send(:extend, described_class)
    end
  end

  let(:child_class) do
    Class.new(base_class)
  end

end
