# encoding: utf-8
require File.expand_path('../lib/cloud_connect/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'addressable', '~> 2.2'
  gem.add_dependency 'faraday', '~> 0.15'
  gem.add_dependency 'faraday_middleware', '~> 0.13.0'
  gem.add_dependency 'hashie', '~> 3.3.2'
  gem.add_dependency 'multi_json'
  gem.add_development_dependency 'json', '~> 2.2'
  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')

  gem.authors       = ['Jean-Paul Bonnetouche']
  gem.summary       = 'Wrapper for the CloudConnect v3 API'
  gem.description   = 'Simple wrapper for the CloudConnect v3 API'
  gem.email         = ['jean-paul.bonnetouche@mobile-devices.fr']
  gem.files         = `git ls-files`.split("\n")
  gem.homepage      = 'https://github.com/mobile-devices/cloud_connect'
  gem.name          = 'cloud_connect'
  gem.platform      = Gem::Platform::RUBY
  gem.require_paths = ['lib']
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version       = CloudConnect::VERSION
end
