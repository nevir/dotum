# `Util`
# ======

# Supporting code for Dotum.
#
# Ideally, everything under `Util` would be factored into external gems, but we
# want Dotum to be able to run outside of the ruby gems environment.
module Dotum::Util
  extend Dotum::AutoloadConvention
end
