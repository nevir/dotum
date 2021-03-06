guard :spork, :rspec_port => 2772 do
  watch('Gemfile')
  watch('Gemfile.lock')

  # Touching any of these files should cause the entire test suite to reload.
  SPEC_ENVIRONMENT_FILES = [
    '.rspec',
    %r{^spec/.*_helper\.rb$},
    %r{^spec/common/.*\.rb$}
  ]

  SPEC_ENVIRONMENT_FILES.each do |pattern|
    watch(pattern) { :rspec }
  end
end

def specs_for_path(path)
  [
    "spec/unit/dotum/#{path}_spec.rb",
    Dir["spec/unit/dotum/#{path}/**/*_spec.rb"]
  ].flatten
end

guard :rspec, :cmd => 'rspec --drb --drb-port 2772' do
  watch('lib/dotum.rb') { 'spec' }
  watch('lib/dotum/autoload_convention.rb') { 'spec' }
  watch(%r{^spec/fixtures/.*\.rb$}) { 'spec' }

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/dotum/(.+)\.rb$}) { |m| specs_for_path(m[1]) }
  watch(%r{^spec/fixtures/(.+?)/.*}) { |m| specs_for_path(m[1]) }
end

RUBOCOP_OPTIONS = ['--require', 'rubocop-rspec']
guard :rubocop, :all_on_start => false, :cli => RUBOCOP_OPTIONS do
  watch('.rubocop.yml') { '.' }

  watch(/.+\.(rb|dotum|rake|gemspec)$/)
  watch('.guardrc')
  watch('.Rakefile')
  watch('.simplecov')
  watch('Gemfile')
  watch('Guardfile')
end
