module Gitlink
  module Rake
    extend ::Rake::DSL

    def self.define_task_for name, config
      config.keys.each { |key| config[key.to_sym] = config.delete(key) }

      desc "Builds and links the #{name} repository."
      task "build:#{name}" do
        repo = Repo.new name, config
        if repo.exists? then repo.update! else repo.create!
        repo.build!
        repo.link!
      end
    end
  end
end
