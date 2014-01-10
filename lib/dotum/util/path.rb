# **Very** similar to `Pathname`.
class Dotum::Util::Path
  include Comparable

  ABSOLUTE_PATH_MATCHER = /^(~?\/|\w+:\\)/

  def initialize(path, relative = nil)
    path = path.to_str.gsub(/[\/\\]/, File::Separator)

    @path = File.expand_path(path, relative)
  end

  # Predicates
  # ----------

  def exists?
    File.exist? @path
  end

  def file?
    File.file? @path
  end

  def directory?
    File.directory? @path
  end

  def symlink?
    File.symlink? @path
  end

  def hidden?
    File.split(@path).any? { |p| p.start_with? '.' }
  end

  # Metadata
  # --------

  def link_path
    self.class.new(File.readlink(@path), File.dirname(@path))
  end

  # Composition
  # -----------

  def dirname
    self.class.new(File.dirname(@path))
  end

  def basename
    File.basename(@path)
  end

  def join(*components)
    (components.size - 1).downto(0) do |i|
      # Do we have absolute paths?  Stop at the last one.
      if components[i].to_str =~ ABSOLUTE_PATH_MATCHER
        return self.class.new(File.join(components[i..-1]))
      end
    end

    self.class.new(File.join(@path, components))
  end

  def glob(expression, &filter)
    matches = Dir.glob(join(expression), File::FNM_DOTMATCH)

    matches.reject! { |p| !filter.call(self.class.new(p)) } if filter
    matches.reject! do |path|
      basename = File.basename(path)

      basename == '.' || basename == '..'
    end

    matches.map { |p| self.class.new(p) }
  end

  def relative_glob(expression, &filter)
    glob(expression, &filter).map { |p| p.relative_to(self) }
  end

  def relative_to(source)
    source_str = source.to_str

    return '.' if @path == source_str

    self_parts   = @path.split(File::Separator)
    source_parts = source_str.split(File::Separator)

    new_parts = []
    self_parts.zip(source_parts) do |self_part, source_part|
      next if self_part == source_part

      new_parts.push(self_part)
      new_parts.unshift('..') unless source_part.nil?
    end

    File.join(new_parts)
  end

  # Input/Output
  # ------------

  def read
    File.read(@path)
  end

  def write(content)
    File.open(@path, 'w') do |file|
      file.write(content)
    end
  end

  # Inspection
  # ----------

  def to_s
    @path
  end

  def to_str
    @path
  end

  def pretty
    home_dir = self.class.home_dir
    return '~' + @path[home_dir.size..-1] if @path.start_with? home_dir

    @path
  end

  def self.home_dir
    @home_dir ||= File.expand_path('~')
  end

  # Comparison
  # ----------

  def <=>(other)
    to_str <=> other.to_str
  end
end
