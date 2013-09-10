puts "<<< #{$stderr.inspect} #{$stderr.fileno} #{$stderr.__id__}"

# Most warnings are triggered from the C layer, which doesn't call out to
# `Kernel#warn`, so we've got to resort to input detection.
class << $stderr

  # DRb sets up `$stdout` as a proxy object, so we can't depend on `write`
  # always existing
  if method_defined? :write
    alias_method :orig_write, :write

    def write(value)
      check_for_warning(value)
      super
    end
  end

  def method_missing(sym, *args, &block)
    check_for_warning(args[0]) if sym == :write
    super
  end

  def check_for_warning(output)
    raise output if output.to_s.include? "warning:"
  end

end
