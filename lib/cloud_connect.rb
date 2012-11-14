require 'cloud_connect/configuration'
require 'cloud_connect/client'
require 'cloud_connect/error'

module CloudConnect
  extend Configuration
  class << self
    # Alias for CloudConnect::Client.new
    #
    # @return [CloudConnect::Client]
    def new(options={})
      CloudConnect::Client.new(options)
    end

    # Delegate to CloudConnect::Client.new
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
