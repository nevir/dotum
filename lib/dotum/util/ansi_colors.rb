# encoding: utf-8

module Dotum::Util::ANSIColors

  def ansi_color(text, code)
    "\e[#{code}m#{text}\e[0m"
  end

  colors = [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white]
  colors.each_with_index do |color, i|
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
