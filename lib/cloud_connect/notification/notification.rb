require 'json'
require 'base64'
require 'faraday_middleware'
require 'faraday/response/raise_cloud_connect_error'

module CloudConnect
  class Notification
    module Notification

      # Notification
      #
      # @param json [String] JSON of the POST request
      # @return [Array] The fields from the json, deserialized and decoded
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0013-notifications
      # @example Notification
      # @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      # @client.notification(json)
      def notification(json)
        result = connection(false, false)
        json = JSON.parse(json)
        if json.class == [].class
          mash = []
          json.each do |obj|
            mash << Hashie::Mash.new(obj)
          end
        else
          mash = Hashie::Mash.new(json)
        end
        return parse_notification(mash)
      end

      alias :list_notification :notification

      module NotificationMethods
        extend CustomMethods
      end

      private

      def decode_b64(b64, type)
        if type == "string"
          return Base64.decode64(b64)
        elsif type == "integer"
          decoded_value = 0
          bytes = Base64.decode64(b64).bytes
          for byte in bytes
            decoded_value <<= 8
            decoded_value += byte
          end
          decoded_value
          return decoded_value
        end
      end

      def decode_notification(mash)
        if mash.meta.event == "message"
          mash.payload.payload = decode_b64(mash.payload.b64_payload, "string")
        elsif mash.meta.event == "track"
          # mash.payload.fields.each do |attr|
          #   attr.last.b64_value = decode_b64(attr.last.b64_value, "integer")
          # end
        end
        return mash
      end

      def parse_notification(mashes)
        if mashes.class == [].class
          mashes.each do |mash|
            mash = parse_notification(mash)
          end
          return mashes
        else
          return decode_notification(mashes)
        end
      end
    end
  end
end