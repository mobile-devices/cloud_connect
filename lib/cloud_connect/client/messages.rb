module CloudConnect
  class Client
    module Messages
      # Get messages
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
  
      module MessageMethods
        extend CustomMethods
      end
    end
  end
end
