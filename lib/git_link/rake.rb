module GitLink
  module Rake
    extend ::Rake::DSL

    def self.define_task_for name, config
      config.keys.each { |key| config[key.to_sym] = config.delete(key) }

      desc "Builds and links the #{name} repository."
      task "#{name}:build" do
        repo = Repo.new name, config
        if repo.exists? then repo.update! else repo.create! end
        repo.build!
        repo.link!
      end

      desc "Removes the #{name} repository and all associated symlinks."
      task "#{name}:clean" do
        repo = Repo.new name, config
        repo.clean! if repo.exists?
      end
    end
  end
end
