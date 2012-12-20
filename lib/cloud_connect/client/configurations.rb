module CloudConnect
  class Client
    module Configurations
      # Get a configuration
      #
      # @param id [String] ID of the configuration
      # @return [Configuration] The configuration you requested, if it exists
      # @example Get configuration 380342888036303061
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.configuration("380342888036303061")
      def configuration(id, options={})
        enhance( get("configs/#{id}", options), with: ConfigurationMethods )
      end

      # Search configurations
      #
      # @param search_term [String] The term to search for
      # @return [Array] A list of configurations matching the search term
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-configurations
      # @example Search for '123' in the configurations
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.search_configurations
      def search_configurations(search_term, options={})
        enhance( get("configs?q=#{search_term}", options), with: ConfigurationMethods )
      end

      # Get all configurations
      #
      # @return [Array] A list of all configurations
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0005-configurations
      # @example List all configurations
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.configurations
      def configurations(options={})
        enhance( get("configs", options), with: ConfigurationMethods )
      end
      alias :list_configurations :configurations

      module ConfigurationMethods
        extend CustomMethods
      end
    end
  end
end
