module CloudConnect
  class Client
    module Assets
      # Get an asset
      #
      # @param imei [String] IMEI of the asset
      # @return [Asset] The asset you requested, if it exists
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0003-assets
      # @example Get asset 0123456789012345
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.asset("0123456789012345")
      def asset(imei, options={})
        enhance( get("assets/#{imei}", options), with: AssetMethods )
      end

      # Search assets
      #
      # @param search_term [String] The term to search for
      # @return [Array] A list of assets matching the search term
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0003-assets
      # @example Search for '123' in the assets
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.search_assets
      def search_assets(search_term, options={})
        enhance( get("assets?q=#{search_term}", options), with: AssetMethods )
      end

      # Get assets
      #
      # @return [Array] A list of all assets
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0003-assets
      # @example List all assets
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.list_assets
      def assets(options={})
        enhance( get("assets", options), with: AssetMethods )
      end
      alias :list_assets :assets

      module AssetMethods
        extend CustomMethods
        # Send a message to the unit
        #
        # @param channel [String] Channel for the message
        # @param payload [String] Payload of the message to send
        # @return [Message] The message
        # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-messages#push_a_message_to_an_asset
        def send_message(channel, payload, opts = {})
          _client.send_message(imei, channel, payload, opts)
        end
  
        def messages(opts = {})
          _client.messages(opts.merge asset: imei)
        end
      end
    end
  end
end
