# `Dotum` API
# ===========
require 'dotum/autoload_convention'

# Dotum makes use of [autoloading](dotum/autoload_convention.html) to enforce
# consistency of file/constant naming, and to keep load times down.
#
# In order to use anything in Dotum, you just need a single
#
#     require 'dotum'
module Dotum
  extend Dotum::AutoloadConvention

  LIB_PATH    = Dotum::Util::Path.new('..',           __FILE__)
  DATA_PATH   = Dotum::Util::Path.new('../../data',   __FILE__)
  EXTERN_PATH = Dotum::Util::Path.new('../../extern', __FILE__)
end

# Global Requires
# ---------------

# While we are generally wary about global requires, there are a few useful ones
# to assume are loaded.
require 'English'
require 'set'
