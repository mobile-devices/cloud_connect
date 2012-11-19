# encoding: utf-8
require File.expand_path('../lib/cloud_connect/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'addressable', '~> 2.2'
  gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'faraday_middleware', '~> 0.8'
  gem.add_dependency 'hashie', '~> 1.2'
  gem.add_dependency 'multi_json', '~> 1.3.7'
  gem.add_development_dependency 'json', '~> 1.7'
  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.authors = ["Jean-Paul Bonnetouche"]
  gem.description = %q{Simple wrapper for the CloudConnect v3 API}
  gem.email = ['jean-paul.bonnetouche@mobile-devices.fr']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/mobile-devices/cloud_connect'
  gem.name = 'cloud_connect'
  gem.platform = Gem::Platform::RUBY
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = gem.description
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = CloudConnect::VERSION
end
