# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ossy/version"

Gem::Specification.new do |spec|
  spec.name          = "ossy"
  spec.version       = Ossy::VERSION
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]

  spec.summary       = "Ossy is your ruby gem maintenance helper"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/solnic/ossy"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir["CHANGELOG.md", "LICENSE", "README.md", "lib/**/*", "bin/ossy"]
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = "bin"
  spec.executables   = "ossy"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "dry-core", "~> 1.0"
  spec.add_runtime_dependency "dry-cli", "~> 1.0"
  spec.add_runtime_dependency "dry-inflector", "~> 1.0"
  spec.add_runtime_dependency "dry-struct", "~> 1.6"
  spec.add_runtime_dependency "dry-configurable", "~> 1.0"
  spec.add_runtime_dependency "dry-system", "~> 1.0"
  spec.add_runtime_dependency "dry-types", "~> 1.6"
  spec.add_runtime_dependency "faraday", "~> 1.0"
  spec.add_runtime_dependency "tilt", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3.3", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "rubocop", "~> 1.6"
end
