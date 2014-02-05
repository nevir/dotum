describe Dotum::AbstractRules::Base, '.exec' do
  include_context 'rule class helpers'

  subject do
    new_rule_class(:SomeRuleClass).tap do |klass|
      klass.class_eval do
        def initialize(context, *args, &block)
          @context = context
          @args = args
          @block = block
        end

        def exec
          [@context, @args, @block]
        end
      end
    end
  end

  it 'should pass through all arguments to initialize' do
    context = Dotum::Context.new
    expect(subject.exec(context, 1, 2, &:asdf)).to eq([
      context, [1, 2], :asdf.to_proc
    ])
  end

end
