# GitLink

GitLink provides functionality to automatically fetch, update, build and symlink git repositories through rake tasks.

It's primarily intended for static assets you want to keep in a seperate repo, such as single-page apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_link', git: 'git@git.noxqsapp.nl:gems/git_link.git'
```

And then execute:

    $ bundle

## Usage

In your Rakefile use the following:

```ruby
  # Simple usage
  GitLink::Rake.define_task_for :name_of_thing, url: 'url_of_your_git_repo'

  # Put repos in an alternate directory, defaults to .repos
  GitLink::Rake.define_task_for :name_of_thing, url: 'url_of_your_git_repo', dir: "#{Dir.home}/.repos"

  # Specify a command to run for compiling your repo if needed, defaults to false
  # Commands are executed inside the linked repo.
  GitLink::Rake.define_task_for :name_of_thing, url: 'url_of_your_git_repo', build: '_scripts/update'

  # Specify which branch to use, defaults to master
  GitLink::Rake.define_task_for :name_of_thing, url: 'url_of_your_git_repo', branch: 'my-feature'

  # Specify which directories to symlink from the repo to your app. Defaults to public => public
  GitLink::Rake.define_task_for :name_of_thing, url: 'url_of_your_git_repo', links: { 'build' => 'public' }
```

This will create the task:

    $ rake gitlink:name_of_thing:build

This will automatically clone your repo or update it if it exists.
It will then run your build command, if any.
Then it will symlink the specified directories from the repo to your app.

It will also create the task:

    $ rake gitlink:name_of_thing:clean

Removing everything again.
