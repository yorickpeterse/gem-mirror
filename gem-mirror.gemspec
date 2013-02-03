require File.expand_path('../lib/gem-mirror/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'gem-mirror'
  s.version     = GemMirror::VERSION
  s.date        = '2012-02-04'
  s.authors     = ['Yorick Peterse']
  s.email       = 'yorickpeterse@gmail.com'
  s.summary     = 'Gem for easily creating your own RubyGems mirror.'
  s.homepage    = 'https://github.com/yorickpeterse/gem-mirror'
  s.description = s.summary
  s.executables = ['gem-mirror']

  s.files = File.read(File.expand_path('../MANIFEST', __FILE__)).split("\n")

  s.has_rdoc              = 'yard'
  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'slop'
  s.add_dependency 'httpclient'
  s.add_dependency 'builder'
  s.add_dependency 'confstruct'

  s.add_development_dependency 'yard'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'rake'
end
