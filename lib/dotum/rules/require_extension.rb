require 'uri'

class Dotum::Rules::RequireExtension < Dotum::AbstractRules::OptionsBase
  shorthand :extension_uri

  required :extension_uri
  optional :legacy
  optional :branch

  def pretty_subject
    @extension_uri
  end

  private

  def execute
    # Does it look like a URI?
    if URI.parse(@extension_uri).scheme
      rule = repo @extension_uri, {:branch => @branch}
      @destination = rule.destination
    # Nope, we're just treating a local directory like a repo.
    else
      @destination = Dotum::Util::Path.new(@extension_uri)
    end

    unless @destination.directory?
      failure! "Failed to clone repo to #{@destination}"
    end

    # Dotum extensions are practically gems, but we don't want the overhead of
    # building a gemspec. Also, `require_extension` is the only supported means
    # of loading them. We don't want magic extensions to be already loaded via
    # gems. Explicit is good here!

    # So, just load all files in the extension and be done with it.
    @destination.glob('lib/**/*.rb').each do |path|
      Kernel.load(path)
    end
  end
end
