# encoding: utf-8

class Dotum::Context

  def initialize(attributes={})
    set_attributes(attributes)
  end

  attr_reader :package_dir
  attr_reader :target_dir
  attr_reader :state_dir

  attr_reader :logger
  attr_reader :depth

  def no_remote?
    @no_remote
  end

  def attributes
    result = {}
    instance_variables.each do |var_name|
      result[var_name[1..-1].to_sym] = instance_variable_get(var_name)
    end

    result
  end

  def fork(new_attributes={})
    self.class.new(attributes.merge(new_attributes || {}))
  end

  def child(new_attributes={})
    new_attributes ||= {}
    new_attributes[:depth] = (@depth || 0) + 1

    fork(new_attributes)
  end

private

  def set_attributes(attributes)
    attributes.each_pair do |key, value|
      case key
      when :package_dir then @package_dir = Dotum::Util::Path.new(value)
      when :target_dir then @target_dir = Dotum::Util::Path.new(value)
      when :state_dir  then @state_dir  = Dotum::Util::Path.new(value)
      when :logger     then @logger     = value
      when :no_remote  then @no_remote  = value
      when :depth      then @depth      = value
      end
    end
  end

end
