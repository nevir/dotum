# `AbstractRules::GlobbableFiles`
# ===============================

# A rule that matches a potentially globbed `source` path, and places matching
# output into `destination`. It behaves like `ln -s`:
#
#  * If `source` is a glob and `destination` is a directory, all matching
#    sources will be placed relative to `destination` (by basename).
#
#  * Otherwise, `source` will be placed with its path relative to `destination`.
#
class Dotum::AbstractRules::GlobbableFiles < Dotum::AbstractRules::OptionsBase
  GLOB_MATCHER = /\*/
  DIR_MATCHER  = %r{[/\\]$}

  shorthand :source => :destination

  required(:source) { |v| context.package_dir.join(v) }
  standard :destination
  # By default, we ignore certain special paths, such as source control state.
  optional :ignore_pattern, %r{(^|[/\\])(\.git|\.svn)([/\\]|$)|rules.dotum$}

  def self.expand_options(context, options)
    sources, destination, destination_is_dir = process(options)
    sources.map do |source_path|
      # Behave like `ln` if the target is a directory; the file is made a direct
      # descendent of that directory.
      if destination_is_dir
        destination_path = File.join(destination, File.basename(source_path))
      elsif destination
        destination_path = destination
      else
        destination_path = source_path
      end

      options.merge(:source => source_path, :destination => destination_path)
    end
  end

  def pretty_subject
    "#{@destination.pretty} (#{@source.pretty})"
  end

  private

  def process(options)
    source      = options[:source]
    destination = options[:destination]

    sources = context.package_dir.relative_glob(source, &:file?)

    source_is_glob     = GLOB_MATCHER =~ source || sources.size > 1
    destination_is_dir = DIR_MATCHER  =~ destination if destination
    if source_is_glob && !destination_is_dir
      fail 'Destination must be a directory when source is a glob expression.'
    end

    sources.reject! { |p| options[:ignore_pattern] =~ p }

    [sources, destination, destination_is_dir]
  end
end
