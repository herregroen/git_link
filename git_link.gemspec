# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_link/version'

Gem::Specification.new do |spec|
  spec.name          = "git_link"
  spec.version       = GitLink::VERSION
  spec.authors       = ["Herre Groen"]
  spec.email         = ["herregroen@gmail.com"]
  spec.summary       = %q{Clones, updates, builds and symlinks git repositories.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "cocaine", "~> 0.5"

  spec.add_development_dependency "bundler", "~> 1.7"
end
