# frozen_string_literal: true

require "bundler"
require "bundler/gem_tasks"
require "bundler/gem_helper"
require "minitest"
require "rake/clean"
require "rake/testtask"
require "rubocop/rake_task"

Bundler::GemHelper.install_tasks name: "gem_mirror"

RuboCop::RakeTask.new

task default: %i[rubocop yard]

# Include the "pkg" and "doc" directories and their contents.
# Include all files ending in ".o" in the current directory
# its subdirectories (recursively).
# CLOBBER.include(pkg, doc, "**/*.o")

# Include InstalledFiles and .config: files created by setup.rb.
# Include temporary files created during test run.
# CLEAN.include(InstalledFiles, .config, "test/**/*.tmp")

require "yard"
YARD::Rake::YardocTask.new do |t|
  t.files   = ["lib/**/*.rb"]          # optional
  t.options = ["--verbose"]            # optional
  t.stats_options = ["--list-undoc"]   # optional
end
