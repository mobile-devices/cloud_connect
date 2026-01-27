require 'faraday'
require 'multi_json'

# @api private
module Faraday
  class Response::RaiseCloudConnectError < Faraday::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 400
        raise CloudConnect::BadRequest, error_message(env)
      when 401
        raise CloudConnect::Unauthorized, error_message(env)
      when 403
        raise CloudConnect::Forbidden, error_message(env)
      when 404
        raise CloudConnect::NotFound, error_message(env)
      when 406
        raise CloudConnect::NotAcceptable, error_message(env)
      when 422
        raise CloudConnect::UnprocessableEntity, error_message(env)
      when 500
        raise CloudConnect::InternalServerError, error_message(env)
      when 501
        raise CloudConnect::NotImplemented, error_message(env)
      when 502
        raise CloudConnect::BadGateway, error_message(env)
      when 503
        raise CloudConnect::ServiceUnavailable, error_message(env)
      end
    end

    def error_message(env)
      message = if (body = env[:body]) && !(body.respond_to?(:empty?) && body.empty?)
        if body.is_a?(String)
          body = MultiJson.load(body, symbolize_keys: true)
        end
        title = body.is_a?(Hash) ? body[:title] : nil
        msg = body.is_a?(Hash) ? body[:message] : nil
        errors = body.is_a?(Hash) ? body[:errors] : nil
        errors_part = errors.respond_to?(:join) ? " Error(s): [#{errors.join(", ")}]" : ""
        " #{title}: #{msg}#{errors_part}"
      else
        ''
      end

      method = env[:method] || env[:http_method]
      url = env[:url]
      "#{method.to_s.upcase} #{url}: #{env[:status]}#{message}"
    end
  end
end
