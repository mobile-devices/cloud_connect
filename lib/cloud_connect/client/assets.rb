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

      # Create an asset
      #
      # @param imei [String] IMEI of the asset
      # @param options [Hash] A customizable set of options
      # @options options [String] :name Name of the asset
      # @options options [String] :serial Serial number of the asset
      # @options options [String] :description Description of the asset
      # @return [Asset] Your newly created asset
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0003-assets#create_a_new_asset
      # @example Create a new Asset
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.create_asset("359551033822346", :name => 'General Lee', :serial => "50030000005322", :description => "The Dukes of Hazzard")
      def create_asset(imei, options={})
        enhance( post("assets", options.merge({:imei => imei})), with: AssetMethods )
      end

      # Update an asset
      #
      # @param imei [String] IMEI of the asset
      # @param options [Hash] A customizable set of options
      # @options options [String] :name Name of the asset
      # @options options [String] :serial Serial number of the asset
      # @options options [String] :description Description of the asset
      # @return [Asset] Your newly updated asset
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0003-assets#update_an_asset
      # @example Update an Asset
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.update_asset("359551033822346", :name => 'General Lee', :serial => "50030000005322", :description => "The Dukes of Hazzard")
      def update_asset(imei, options={})
        enhance( put("assets/#{imei}", options.merge({:imei => imei})), with: AssetMethods )
      end

      # Delete a single asset
      #
      # @param imei [String] IMEI fo the field
      # @return [Response] A response object with status
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0003-assets#delete_an_asset
      # @example Delete the "359551033822346" asset
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.delete_asset("359551033822346")
      def delete_asset(imei, options={})
        delete("assets/#{imei}", options, true)
      end

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
