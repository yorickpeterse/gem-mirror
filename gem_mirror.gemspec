# frozen_string_literal: true

require_relative "lib/gem_mirror/version"

Gem::Specification.new do |s|
  s.name                  = "gem_mirror"
  s.version               = GemMirror::Version::STRING
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0")
  s.authors               = ["Yorick Peterse", "Patrick Callahan"]
  s.description           = <<~DESCRIPTION
    gem-mirror is a tool for creating and managing a private
    mirror of RubyGems. It is also suitable for hosting private
    gems.
  DESCRIPTION

  s.email                 = ["pmc@patrickcallahan.com"]
  s.files                 = Dir["{assets,config,lib}/**/*"] + ["gem_mirror.gemspec"]
  s.require_paths         = ["lib"]
  s.bindir                = "exe"
  s.executables           = %w[gem_mirror]
  s.extra_rdoc_files      = Dir["LICENSE.txt", "README.md"]
  s.homepage              = "https://github.com/dirtyharrycallahan/gem_mirror"
  s.licenses              = ["MIT"]
  s.summary               = %q{A tool for creating and managing a private rubygems mirror.}

  if $PROGRAM_NAME.end_with?("gem") && ARGV == ["build", __FILE__]
    spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem")
  end

  s.rdoc_options += [
    "--title", "gem_mirror - A Tool for Managing a Private Gem Repositor",
    "--main", "README.md",
    "--line-numbers",
    "--inline-source",
    "--quiet"
  ]
  s.metadata["allowed_push_host"] = "https://rubygems.org"
  s.metadata["changelog_uri"]     = "https://github.com/dirtyharrycallahan/gem_mirror/blob/master/CHANGELOG.md"
  s.metadata["homepage_uri"]      = s.homepage
  s.metadata["source_code_uri"]   = s.homepage
  s.metadata["bug_tracker_uri"]   = "https://github.com/dirtyharrycallahan/gem_mirror/issues"

  s.add_runtime_dependency("confstruct", "~> 1.0", "< 2")
  s.add_runtime_dependency("httpclient", "~> 2.8", "< 3")
  s.add_runtime_dependency("slop",       "~> 4.9", "< 5")

  s.add_development_dependency("bundler",             ">= 1.17.3", "< 3.0")
  s.add_development_dependency("rake",                ">= 13.0.0", "< 14")
  s.add_development_dependency("rake-manifest",       "~> 0.2.0")
  s.add_development_dependency("redcarpet",           "~> 3.5.0")
  s.add_development_dependency("rspec",               "~> 3.2")
  s.add_development_dependency("rubocop",             "= 1.15.0")
  s.add_development_dependency("rubocop-performance", "= 1.11.3")
  s.add_development_dependency("rubocop-rake",        "= 0.5.1")
  s.add_development_dependency("rubocop-rspec",       "= 2.3.0")
  s.add_development_dependency("yard",                "~> 0.9.0")
end
