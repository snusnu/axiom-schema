# encoding: utf-8

require File.expand_path('../lib/axiom/schema/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'axiom-schema'
  gem.summary       = 'Relation schema for axiom relations'
  gem.description   = gem.summary
  gem.authors       = ['Martin Gamsjaeger (snusnu)']
  gem.email         = ['gamsnjaga@gmail.com']
  gem.homepage      = 'http://rom-rb.org'
  gem.require_paths = ['lib']
  gem.version       = Axiom::Schema::VERSION.dup
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.license       = 'MIT'

  gem.add_dependency 'axiom',           '~> 0.1.1'
  gem.add_dependency 'axiom-optimizer', '~> 0.1.1'
  gem.add_dependency 'addressable',     '~> 2.3', '>= 2.3.5'
  gem.add_dependency 'concord',         '~> 0.1.4'
  gem.add_dependency 'abstract_type',   '~> 0.0.7'
  gem.add_dependency 'adamantium',      '~> 0.1'
end
