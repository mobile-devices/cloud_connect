require 'faraday'
require 'faraday_middleware'
require 'forwardable'

begin
  require 'yajl'
  MultiJson.engine = :yajl
rescue LoadError
  require 'json'
  MultiJson.engine = :json_gem
end

module CloudConnect
  class << self
    attr_accessor :username
    attr_accessor :password
    attr_accessor :account
    attr_accessor :env

    require 'ext/object'
    require 'ext/module'
    require 'ext/hash'

    require 'faraday/cookie_auth'
    require 'faraday/raise_http_4xx'
    require 'faraday/raise_http_5xx'

    require 'cloud_connect/error'
    require 'cloud_connect/client/units'
    require 'cloud_connect/client/users'
    require 'cloud_connect/client/messages'
    require 'cloud_connect/client/trackings'
    require 'cloud_connect/client/channels'
    require 'cloud_connect/client/fields'
    require 'cloud_connect/client'
  end
end
