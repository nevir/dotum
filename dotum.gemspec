require File.expand_path('../lib/dotum/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name     =  'dotum'
  gem.summary  = 'Dotum manages your dotfiles and allows for piecemeal sharing.'
  gem.authors  = ['Ian MacLeod']
  gem.email    = ['ian@nevir.net']
  gem.homepage =  'https://github.com/nevir/dotum'
  gem.license  =  'MIT'

  gem.version  = Dotum::Version.string
  gem.platform = Gem::Platform::RUBY

  gem.files      = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {spec}/*`.split("\n")

  gem.require_paths = ['lib']
end
