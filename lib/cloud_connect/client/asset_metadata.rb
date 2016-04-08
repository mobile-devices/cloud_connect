module CloudConnect
  class Client
    module AssetMetadata
      # Get an asset metadatum
      #
      # @param imei [String] IMEI of the asset
      # @param name [String] name of the metadata
      # @return [Asset] The asset you requested, if it exists
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation-draft/cc-0016-assets-metadata
      # @example Get metadata 'make' of the asset 0123456789012345
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.asset_metadatum("0123456789012345", "make")
      def asset_metadatum(imei, name, options={})
        get("assets/#{imei}/metadata/#{name}", options)
      end

      # Search asset metadata
      #
      # @param imei [String] IMEI of the asset
      # @param search_term [String] The term to search for
      # @return [Array] A list of asset metadata matching the search term
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation-draft/cc-0016-assets-metadata
      # @example Search for '123' in the metadata of the asset with imei "359551033822346"
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.search_asset_metadata("359551033822346","value:123")
      def search_asset_metadata(imei, search_term, options={})
        get("assets/#{imei}/metadata?q=#{search_term}", options)
      end

      # Get asset metadata
      #
      # @param imei [String] IMEI of the asset
      # @return [Array] A list of all asset metadata
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation-draft/cc-0016-assets-metadata
      # @example List all metadata of the "359551033822346" asset
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.list_assets("359551033822346")
      def asset_metadata(imei, options={})
        get("assets/#{imei}/metadata", options)
      end
      alias :list_asset_metadata :asset_metadata

      # Create an asset metadatum
      #
      # @param imei [String] IMEI of the asset
      # @param name  [String] name of the asset metadatum
      # @param value [String] value of the asset metadatum
      # @param type  [String] data type of the asset metadatum
      # @return [Asset Metadatum] Your newly created asset metadatum
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation-draft/cc-0016-assets-metadata#create_a_new_asset_metadatum
      # @example Create a new Asset Metadatum
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.create_asset_metadatum("359551033822346", 'year', '2012', 'integer')
      def create_asset_metadatum(imei, name, value, type='string')
        post("assets/#{imei}/metadata", {:name => name, :value => value, :type => type})
      end

      # Update an asset metadatum
      #
      # @param imei  [String] IMEI of the asset
      # @param name  [String] name of the asset metadatum
      # @param value [String] value of the asset metadatum
      # @return [AssetMetadatum] Your newly updated asset metadatum
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation-draft/cc-0016-assets-metadata#update_an_asset_metadatum
      # @example Update an AssetMetadatum
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.update_asset_metadatum("359551033822346", 'make', 'SuchAGreatCarMaker')
      def update_asset_metadatum(imei, name, value)
        put("assets/#{imei}/metadata/#{name}", {:value => value})
      end

      # Delete a single asset metadatum
      #
      # @param imei [String] IMEI of the asset
      # @param name [String] name of the asset metadatum
      # @return [Response] A response object with status
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation-draft/cc-0016-assets-metadata#delete_an_asset_metadatum
      # @example Delete the "make" metadata of the "359551033822346" asset
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.delete_asset_metadatum("359551033822346", "make")
      def delete_asset_metadatum(imei, name, options={})
        delete("assets/#{imei}/metadata/#{name}", options, true)
      end
    end
  end
end
