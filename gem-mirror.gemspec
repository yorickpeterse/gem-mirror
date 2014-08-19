require File.expand_path('../lib/gem-mirror/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name        = 'gem-mirror'
  spec.version     = GemMirror::VERSION
  spec.date        = '2014-08-18'
  spec.authors     = ['Yorick Peterse', 'Patrick Callahan']
  spec.email       = ['yorickpeterse@gmail.com', 'pmc@patrickcallahan.com']
  spec.summary     = 'Gem for easily creating your own RubyGems mirror.'
  spec.homepage    = 'https://github.com/dirtyharrycallahan/gem-mirror'
  spec.description = spec.summary
  spec.executables = ['gem-mirror']
  spec.licenses    = ['MIT']

  spec.files = File.read(File.expand_path('../MANIFEST', __FILE__)).split("\n")

  spec.has_rdoc              = 'yard'
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'slop',       '~> 3.4', '>= 3.4.0'
  spec.add_runtime_dependency 'httpclient', '~> 2.4', '>= 2.4.0'
  spec.add_runtime_dependency 'builder',    '~> 3.0', '>= 3.0.0'
  spec.add_runtime_dependency 'confstruct', '~> 0.2', '>= 0.2.0'

  spec.add_development_dependency 'yard',      '~> 0.8', '>= 0.8.1'
  spec.add_development_dependency 'redcarpet', '~> 3.1', '>= 3.1.0'
  spec.add_development_dependency 'rake',      '~> 1.9'
end
