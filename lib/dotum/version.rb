# Current Version
# ===============

module Dotum
  # Version information for Dotum.
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 0

    # Dotum's version number as a string.
    def self.string
      "#{MAJOR}.#{MINOR}.#{PATCH}"
    end
  end
end
