class Dotum::Rules::Repo < Dotum::AbstractRules::OptionsBase
  shorthand :repo_uri => :destination

  required :repo_uri
  standard :destination
  optional :branch

  attr_reader :destination

  def pretty_subject
    @repo_uri
  end

  private

  def execute
    @destination ||= default_destination
    @repo_exists = @destination.join('.git').directory?

    if !is_local? && context.no_remote?
      if @repo_exists
        skip! 'Remote interactions are disabled.'
      else
        failure! 'Remote interactions are disabled; cannot clone!'
      end
    end

    if @repo_exists
      update_repo
    else
      clone_repo
    end
  end

  def clone_repo
    command = ['git', 'clone']
    command += ['--branch', @branch] if @branch
    command += [@repo_uri, @destination]

    run *command
  end

  def update_repo
    cd @destination do
      run 'git', 'add', '--all'
      run 'git', 'commit', '--quiet', '--allow-empty', '--message', 'Dotum Temp'
      run 'git', 'pull', '--rebase'
      run 'git', 'reset', 'HEAD^'
    end
  end

  def default_destination
    basename = [@repo_uri, @branch].compact.join('-').gsub(%r{[/:]+}, '-')

    context.state_dir.join('repo', basename)
  end

  def is_local?
    @repo_uri.start_with? 'file://'
  end
end
