# `Util::ANSIControl`
# ===================

# Extend a class with `ANSIControl` to gain access to ANSI coloring and other
# escape sequences.
module Dotum::Util::ANSIControl
  COLORS = [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white]

  def ansi_color(text, code)
    "\e[#{code}m#{text}\e[0m"
  end

  COLORS.each_with_index do |color, i|
    color_code = 30 + i

    module_eval <<-end_eval, __FILE__, __LINE__

      def c_#{color}(text)
        ansi_color(text, "#{color_code}")
      end

      def c_bright_#{color}(text)
        ansi_color(text, "#{color_code};1")
      end

    end_eval
  end
end
