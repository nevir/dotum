desc 'Boot up a console w/ Dotum preloaded'
task :console do
  require 'dotum'
  require 'pry'

  Pry.start
end
