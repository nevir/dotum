require 'uri'

class Dotum::Rules::UseRepo < Dotum::AbstractRules::OptionsBase

  shorthand :repo_uri

  required :repo_uri
  optional :legacy
  optional :branch

  def pretty_subject
    @repo_uri
  end

private

  def execute
    # Does it look like a URI?
    if URI.parse(@repo_uri).scheme
      rule = repo @repo_uri, {:branch => @branch}
      @destination = rule.destination
    # Nope, we're just treating a local directory like a repo.
    else
      @destination = Dotum::Util::Path.new(@repo_uri)
    end

    failure! "Failed to clone repo to #{@destination}" unless @destination.directory?
    # We are now located within the repo.
    @context = context.fork(:package_dir => @destination)

    if @legacy
      execute_legacy
    else
      execute_dotum
    end
  end

  def execute_dotum
    # Straight up `use` the repo if it is rooted with a `rules.dotum`.
    if @destination.join('rules.dotum').file?
      use '.'

    # Otherwise, this is a 'meta-package' that contains child packages.
    else
      @destination.relative_glob('*', &:directory?).each do |package_path|
        use package_path
      end
    end
  end

  def execute_legacy
    # In legacy mode, we just symlink everything
    link '**/*'
  end

end
