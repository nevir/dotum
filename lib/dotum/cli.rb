require "fileutils"

class Dotum::CLI

  def self.exec(args)
    new(args).exec!
  end

  def initialize(args)
    @args = args

    @state_dir  = Dotum::Util::Path.new("~/.dotum")
    @target_dir = Dotum::Util::Path.new("~")
    @package_dir = Dotum::Util::Path.new("~/.dotum/local")
  end

  def exec!
    context = Dotum::Context.new(
      # :no_remote  => true,
      :state_dir  => @state_dir,
      :target_dir => @target_dir,
      :logger     => Dotum::Logger.new
    )

    unless @package_dir.directory?
      puts
      puts "#{@package_dir.pretty} doesn't exist!  Creating for now..."
      FileUtils.mkpath(@package_dir)
    end

    Dotum::Rules::UseRepo.exec(context, @package_dir)
    print "\n\n"
  end

end
