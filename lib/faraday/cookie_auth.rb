module Faraday
  class Request::CookieAuth < Faraday::Middleware
    delegate :cookie, :cookie=, :to => :@client, :allow_nil => true

    def call(env)
      env[:request_headers]['Cookie'] = cookie if cookie

      env[:response].on_complete do |finished_env|
        if finished_env[:response_headers]['set-cookie']
          self.cookie = finished_env[:response_headers]['set-cookie'].split('; ')[0]
        end
      end

      @app.call(env)
    end

    def initialize(app, client = nil)
      @app, @client = app, client
    end
  end
end
