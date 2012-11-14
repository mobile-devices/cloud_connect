require 'faraday'
require 'cloud_connect/version'

module CloudConnect
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :faraday_config_block,
      :api_version,
      :api_url,
      :api_path,
      :account,
      :token,
      :proxy,
      :request_host,
      :user_agent,
      :auto_traversal,
      :per_page,
    ].freeze

    API_VERSION            = 3

    DEFAULT_ADAPTER        = Faraday.default_adapter
    DEFAULT_API_URL        = "cloudconnect.io"
    API_PATH               = "/api/v#{API_VERSION}/"
    DEFAULT_USER_AGENT     = "CloudConnect Ruby Gem #{CloudConnect::VERSION}".freeze
    DEFAULT_AUTO_TRAVERSAL = false

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def faraday_config(&block)
      @faraday_config_block = block
    end

    def reset
      self.adapter        = DEFAULT_ADAPTER
      self.api_version    = API_VERSION
      self.api_url        = DEFAULT_API_URL
      self.api_path       = API_PATH
      self.account        = nil
      self.token          = nil
      self.proxy          = nil
      self.request_host   = nil
      self.user_agent     = DEFAULT_USER_AGENT
      self.auto_traversal = DEFAULT_AUTO_TRAVERSAL
    end
  end
end
