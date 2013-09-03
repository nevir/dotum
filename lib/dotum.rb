require "dotum/autoload_convention"

module Dotum
  extend Dotum::AutoloadConvention

  LIB_PATH    = Dotum::Util::Path.new("..",         __FILE__)
  DATA_PATH   = Dotum::Util::Path.new("../../data", __FILE__)
  EXTERN_PATH = Dotum::Util::Path.new("../../extern", __FILE__)
end
