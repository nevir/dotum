# encoding: utf-8

class Dotum::AbstractRules::GlobbableFiles < Dotum::AbstractRules::OptionsBase

  GLOB_MATCHER = /\*/
  DIR_MATCHER  = /[\/\\]$/

  shorthand :source => :destination

  required(:source) { |v| context.package_dir.join(v) }
  standard :destination
  # By default, we ignore certain special paths, such as source control state.
  optional :ignore_pattern, /(^|[\/\\])(\.git|\.svn)([\/\\]|$)|rules.dotum$/

  def self.expand_options(context, options)
    source      = options[:source]
    destination = options[:destination]

    source_is_glob = GLOB_MATCHER === source
    target_is_dir  = DIR_MATCHER  === destination if destination
    if source_is_glob && destination && !target_is_dir
      raise "target path must be a directory when linking a glob expression."
    end

    sources = context.package_dir.relative_glob(source, &:file?)
    if sources.size > 1 && destination && !target_is_dir
      raise "Bug!  target path is a file, but we globbed multiple sources!"
    end

    sources.reject! { |p| options[:ignore_pattern] =~ p }

    sources.map { |source_path|
      # Behave like `ln` if the target is a directory; the file is made a direct
      # descendent of that directory.
      if target_is_dir
        destination_path = File.join(destination, File.basename(source_path))
      elsif destination
        destination_path = destination
      else
        destination_path = source_path
      end

      options.merge(:source => source_path, :destination => destination_path)
    }
  end

  def pretty_subject
    "#{@destination.pretty} (#{@source.pretty})"
  end

end
