require 'faraday'
require 'hashie'

module CloudConnect
  module FaradayMiddleware
    class Mashify < Faraday::Middleware
      def on_complete(env)
        env.body = mashify(env.body)
      end

      private

      def mashify(obj)
        case obj
        when Array
          obj.map { |v| mashify(v) }
        when Hash
          Hashie::Mash.new(obj.transform_values { |v| mashify(v) })
        else
          obj
        end
      end
    end
  end
end

