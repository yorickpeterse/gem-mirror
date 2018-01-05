require File.expand_path('../lib/gem-mirror/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "gem-mirror"
  spec.version     = GemMirror::VERSION
  spec.date        = "2018-01-05"
  spec.authors     = ["Yorick Peterse", "Patrick Callahan"]
  spec.email       = ["yorickpeterse@gmail.com", "pmc@patrickcallahan.com"]
  spec.summary     = "Gem for easily creating your own RubyGems mirror."
  spec.homepage    = "https://github.com/dirtyharrycallahan/gem-mirror"
  spec.description = spec.summary
  spec.executables = ["gem-mirror"]
  spec.licenses    = ["MIT"]

  spec.files = File.read(File.expand_path('../MANIFEST', __FILE__)).split("\n")

  spec.has_rdoc              = 'yard'
  spec.required_ruby_version = '>= 2.4.0'

  spec.add_runtime_dependency 'slop',       '~> 3.4', '>= 3.4.0'
  spec.add_runtime_dependency 'httpclient', '~> 2.8', '>= 2.8.0'
  spec.add_runtime_dependency 'builder',    '~> 3.2', '>= 3.2.0'
  spec.add_runtime_dependency 'confstruct', '~> 1.0', '>= 1.0.0'

  spec.add_development_dependency 'yard',      '~> 0.9', '>= 0.9.12'
  spec.add_development_dependency 'redcarpet', '~> 3.4', '>= 3.4.0'
  spec.add_development_dependency 'rake',      '~> 2.4'
end
