shared_context 'simple rule' do

  let(:context) do
    Dotum::Context.new
  end

  let(:rule_class) do
    klass = Class.new(Dotum::AbstractRules::OptionsBase)
    klass.extend subject
    klass.class_eval do
      def pretty_subject
        'simple rule'
      end

      def execute
        'no-op'
      end
    end

    klass
  end

  let(:rule) do
    rule_class.new
  end

end
