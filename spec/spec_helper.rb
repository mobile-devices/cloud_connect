require 'bundler/setup'
require 'rspec'

require 'cloud_connect'

RSpec.configure do |config|
  config.order = :random
  config.disable_monkey_patching!
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end

