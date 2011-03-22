module Faraday
  class Response::RaiseHttp4xx < Response::Middleware
    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        case response[:status].to_i
        when 400
          raise CloudConnect::BadRequest, error_message(response)
        when 401
          raise CloudConnect::Unauthorized, error_message(response)
        when 403
          raise CloudConnect::Forbidden, error_message(response)
        when 404
          raise CloudConnect::NotFound, error_message(response)
        when 406
          raise CloudConnect::NotAcceptable, error_message(response)
        when 422
          raise CloudConnect::UnprocessableEntity, error_message(response)
        #when 420
        #  raise CloudConnect::EnhanceYourCalm.new error_message(response), response[:response_headers]
        end
      end
    end

    def initialize(app)
      super
      @parser = nil
    end

    private

    def self.error_message(response)
      if response[:body] && response[:body].is_a?(Hash) && response[:body]['error']
        "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:response_headers]['status']}: #{(response[:body]['error'])}"
      elsif response[:body] && response[:body].is_a?(Array)
        "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:response_headers]['status']}: #{(response[:body].join(', '))}"
      else
        "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:response_headers]['status']}: #{(response[:body])}"
      end
    end
  end
end
