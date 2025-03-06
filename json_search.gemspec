# frozen_string_literal: true

require_relative 'lib/json_search/version'

Gem::Specification.new do |spec|
  spec.name          = 'json_search'
  spec.version       = JsonSearch::VERSION
  spec.authors       = ['Jibril Tapiador']
  spec.email         = ['tapiador@jib.is']

  spec.summary       = 'Shiftcare take home test'
  spec.description   = 'Shiftcare take home test'
  spec.homepage      = 'https://github.com/jibril-tapiador/json_search'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'bin/*', 'README.md', 'data/**/*', '*.gemspec']
  spec.executables   = ['json_search']
  spec.require_paths = ['lib']

  spec.add_dependency 'json', '~> 2.5'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
