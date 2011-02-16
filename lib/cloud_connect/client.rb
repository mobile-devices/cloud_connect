module CloudConnect
  class Client
    attr_reader :username, :password, :account, :env, :cookie
    attr_writer :cookie

    def initialize(options={})
      @username = options[:username] || CloudConnect.username
      @password = options[:password] || CloudConnect.password
      @account  = options[:account]  || CloudConnect.account
      @env      = options[:env]      || CloudConnect.env      || "prod"
    end

    # Raw HTTP connection, either Faraday::Connection
    #
    # @return [Faraday::Connection]
    def connection
      params = {}
      params[:access_token] = @access_token if @access_token
      @connection ||= Faraday::Connection.new(:url => api_url, :params => params, :headers => default_headers) do |builder|
        builder.use Faraday::Request::CookieAuth, self
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::RaiseHttp5xx
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::RaiseHttp4xx
        builder.use Faraday::Response::Mashify
        #builder.response :yajl     # Faraday::Request::Yajl
      end
    end

    # Provides the URL for accessing the API
    #
    # @return [String]
    def api_url
      if env == "preprod"
        "http://srv/api/v2"
      else
        "http://#{env}.g8teway.com/api/v2"
      end
    end


    def login
      req = connection.post('sessions', {:login => username, :password => password, :client => account})
    end

    private
      # @private
      def default_headers
        headers = {
          :accept =>  'application/json',
          :user_agent => 'CloudClient Ruby gem'
        }
      end

    include Units
    include Users
    include Channels
    include Messages
    include Fields
    include Trackings
  end
end
