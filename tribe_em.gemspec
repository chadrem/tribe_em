# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tribe_em/version'

Gem::Specification.new do |gem|
  gem.name          = 'tribe_em'
  gem.version       = Tribe::EM::VERSION
  gem.authors       = ['Chad Remesch']
  gem.email         = ['chad@remesch.com']
  gem.description   = %q{Event driven network IO for the Tribe gem.}
  gem.summary       = %q{Quickly create network servers using EventMachine and Tribe.}
  gem.homepage      = 'https://github.com/chadrem/tribe_em'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency('tribe', '~> 0.2')
  gem.add_dependency('eventmachine', '>= 1.0.0')
end
