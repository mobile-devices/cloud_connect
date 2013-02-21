module CloudConnect
  class Client
    module Messages
      # Get a message
      #
      # @param id [String] ID of the message
      # @return [Message] The message you requested, if it exists
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-messages
      # @example Get message 380342888036303061
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.message("380342888036303061")
      def message(id, options={})
        enhance( get("messages/#{id}", options), with: MessageMethods )
      end

      # Search messages
      #
      # @param search_term [String] The term to search for
      # @return [Array] A list of messages matching the search term
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-messages
      # @example Search for '123' in the messages
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.search_messages
      def search_messages(search_term, options={})
        enhance( get("messages?q=#{search_term}", options), with: MessageMethods )
      end

      # Get messages from an asset
      #
      # @param imei [String] IMEI of the asset
      # @return [Array] The messages you requested, if it exists
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-messages
      # @example Get messages from the asset 351732050019192
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.asset_messages("351732050019192")
      def asset_messages(imei, options={})
        enhance( get("assets/#{imei}/messages", options), with: MessageMethods )
      end

      # Get all messages
      #
      # @return [Array] A list of all messages
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-messages
      # @example List all messages
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.messages
      def messages(options={})
        enhance( get("messages", options), with: MessageMethods )
      end
      alias :list_messages :messages

      # Send a message to the unit
      #
      # @param imei [String] IMEI of the asset
      # @param channel [String] Channel for the message
      # @param payload [String] Payload of the message to send
      # @return [Message] The message
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-messages#push_a_message_to_an_asset
      def send_message(imei, channel, payload, options={})
        enhance( post("messages", options.merge({recipient: imei, asset: imei, channel: channel, b64_payload: Base64.encode64(payload)})), with: MessageMethods )
      end

      module MessageMethods
        extend CustomMethods
      end
    end
  end
end
