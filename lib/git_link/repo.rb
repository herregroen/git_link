require 'fileutils'

module GitLink
  class Repo
    DEFAULT_OPTIONS = {
      dir:    '.repos',
      branch: 'master',
      links:  { 'public' => 'public' },
      build:  false
    }

    attr_reader :name, :url, :options
    attr_writer :updated

    def initialize name, opts={}
      raise "Must provide a URL for the GitLinked repo #{name}" unless opts.has_key?(:url)

      @name    = name.to_s
      @url     = opts.delete(:url)
      @options = DEFAULT_OPTIONS.merge(opts)
      @updated = false

      ensure_dir
    end

    def exists?
      Dir.exist? path
    end

    def create!
      git_clone
      git_checkout
      updated = true
    end

    def update!
      rev = git_rev
      git_checkout
      git_pull
      updated = true if rev != git_rev
    end

    def build!
      if options[:build] and updated
        Dir.chdir path do
          Cocaine::CommandLine.new(options[:build]).run
        end
      end
    end

    def link!
      options[:links].each do |from, to|
        File.symlink "#{path}/#{from}", to  unless File.exists?(to) or File.symlink?(to)
      end
    end

    private

    def path
      "#{options[:dir]}/#{name}"
    end

    def ensure_dir
      FileUtils.mkpath(options[:dir]) unless File.exists?(options[:dir])
    end

    def git_clone
      Dir.chdir options[:dir] do
        Cocaine::CommandLine.new('git', 'clone :url :name').run url: url, name: name
      end
    end

    def git_checkout
      Dir.chdir path do
        Cocaine::CommandLine.new('git', 'checkout :branch').run branch: options[:branch]
      end
    end

    def git_pull
      Dir.chdir path do
        Cocaine::CommandLine.new('git', 'pull origin :branch').run branch: options[:branch]
      end
    end

    def git_rev
      Dir.chdir path do
        Cocaine::CommandLine.new('git', 'rev-parse HEAD').run
      end
    end
  end
end
