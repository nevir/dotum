shared_context 'rule class helpers' do
  def new_rule_class(name)
    scope = Module.new
    scope.module_eval <<-end_module, __FILE__, __LINE__
      class #{name} < #{described_class}; end
    end_module

    scope.const_get(name)
  end

end
