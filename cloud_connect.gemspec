# -*- encoding: utf-8 -*-
require File.expand_path("../lib/cloud_connect/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cloud_connect"
  s.version     = CloudConnect::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jean-Paul Bonnetouche"]
  s.email       = ["jean-paul.bonnetouche@mobile-devices.fr"]
  s.homepage    = "http://rubygems.org/gems/cloud_connect"
  s.summary     = "Wrapper for Cloud Connect"
  s.description = "Ruby Wrapper for the Mobile Devices Cloud Connect API"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency "json"
  s.add_runtime_dependency "multi_json", "~> 0.0.0"
  s.add_runtime_dependency "faraday", "~> 0.5.0"
  s.add_runtime_dependency "faraday_middleware", "~> 0.1.6"
  s.add_runtime_dependency "hashie", "~> 0.4.0"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "bluecloth", ">= 2.0"
  s.add_development_dependency "rake", "~> 0.8"
  #s.add_development_dependency "yard", "~> 0.6"
  s.add_development_dependency "rspec"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
