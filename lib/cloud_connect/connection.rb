require 'faraday_middleware'
require 'faraday/response/raise_cloud_connect_error'

module CloudConnect
  # @private
  module Connection
    private

    def api_endpoint
      File.join(@api_url, @api_path, "")
    end

    def url
      url = "http://#{[account, api_endpoint].join('.')}"
    end

    def connection(raw=false, force_urlencoded=false)
      options = {
        :ssl => { :verify => false },
        :url => url,
      }

      options[:proxy] = proxy unless proxy.nil?

      # TODO: Don't build on every request
      connection = Faraday.new(options) do |builder|
        if !force_urlencoded
          builder.request :json
        else
          builder.request :url_encoded
        end

        builder.use Faraday::Response::RaiseCloudConnectError

        unless raw
          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson
        end

        faraday_config_block.call(builder) if faraday_config_block

        builder.adapter *adapter
      end

      connection.basic_auth authentication[:token], 'X'
      connection
    end
  end
end
