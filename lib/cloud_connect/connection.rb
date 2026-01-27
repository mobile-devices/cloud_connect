require 'faraday'
require 'faraday/response/raise_cloud_connect_error'
require 'cloud_connect/faraday_middleware/mashify'

module CloudConnect
  # @private
  module Connection
    private

    def api_endpoint
      File.join(@api_url, @api_path, "")
    end

    def url
      url = "https://#{[account, api_endpoint].join('.')}"
    end

    def connection(raw=false, force_urlencoded=false)
      options = {
        :ssl => { :verify => false },
        :url => url,
      }

      options[:proxy] = proxy unless proxy.nil?

      # TODO: Don't build on every request
      connection = Faraday.new(options) do |builder|
        builder.request :authorization, :basic, authentication[:token], 'X' if authentication[:token]

        if !force_urlencoded
          builder.request :json
        else
          builder.request :url_encoded
        end

        builder.use Faraday::Response::RaiseCloudConnectError

        unless raw
          builder.use CloudConnect::FaradayMiddleware::Mashify
          builder.response :json
        end

        faraday_config_block.call(builder) if faraday_config_block

        builder.adapter *adapter
      end
      connection
    end
  end
end
