# Autoload Convention
# ===================
# We adhere to a strict convention for the constants in this library:
#
# `Camel::Caps::BasedConstants` map to their underscore variants of
# `camel/caps/based_constants`.
#
# Each autoloadable parent module/class only needs to to `extend` the
# `AutoloadConvention` to bootstrap this behavior.
module Dotum
  module AutoloadConvention

    # `autoload` is dead, and we don't want to deal with its removal in 2.0,
    # so here's a thread-unsafe poor man's solution.
    def const_missing(sym)
      full_sym   = "#{name}::#{sym}"
      path_parts = full_sym.split("::").map { |part|
        part.gsub! /([^A-Z])([A-Z]+)/,       "\\1_\\2" # OneTwo -> One_Two
        part.gsub! /([A-Z]+)([A-Z][^A-Z]+)/, "\\1_\\2" # ABCOne -> ABC_One

        part.downcase
      }

      load "#{File.join(path_parts)}.rb"

      # Make sure that we don't get stuck in an endless loop.  `const_get` calls
      # into `const_missing`, so we can't use that.
      eval "defined?(#{full_sym}) ? #{full_sym} : super"
    end

  end
end
