# frozen_string_literal: true

require_relative "lib/capistrano/good_job/version"

Gem::Specification.new do |spec|
  spec.name = "capistrano-good-job"
  spec.version = CapistranoGoodJob::VERSION
  spec.authors = ["Martin Tomov"]

  spec.summary = "Adds support for GoodJob to Capistrano 3.x"
  spec.description = "Adds support for GoodJob to Capistrano 3.x"
  spec.homepage = "https://github.com/mtomov/capistrano-good-job"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mtomov/capistrano-good-job"
  spec.metadata["changelog_uri"] = "https://github.com/mtomov/capistrano-good-job/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
