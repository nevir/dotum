# encoding: utf-8

SimpleCov.start do
  add_filter "/spec/"
  add_filter "lib/dotum/externs/"

  add_group "Base" do |file|
    file.filename =~ /lib\/dotum(\/)?[^\/]+$/
  end
  add_group "Abstract Rules",   "lib/dotum/abstract_rules/"
  add_group "Rules",            "lib/dotum/rules/"
  add_group "Standard Options", "lib/dotum/standard_options/"
  add_group "Utility",          "lib/dotum/util/"

  # minimum_coverage 100
end
