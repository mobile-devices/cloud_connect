require 'faraday'
require 'multi_json'

# @api private
module Faraday
  class Response::RaiseCloudConnectError < Response::Middleware
    def on_complete(response)
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
      when 500
        raise CloudConnect::InternalServerError, error_message(response)
      when 501
        raise CloudConnect::NotImplemented, error_message(response)
      when 502
        raise CloudConnect::BadGateway, error_message(response)
      when 503
        raise CloudConnect::ServiceUnavailable, error_message(response)
      end
    end

    def error_message(response)
      message = if (body = response[:body]) && !body.empty?
        if body.is_a?(String)
          body = MultiJson.load(body, :symbolize_keys => true)
        end
        " #{body[:title]}: #{body[:message]} Error(s): [#{body[:errors].join(", ")}]"
      else
        ''
      end
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{message}"
    end
  end
end
