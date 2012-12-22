module CloudConnect
  class Client
    module Configurations
      # Get a configuration
      #
      # @param id [String] ID of the configuration
      # @return [Configuration] The configuration you requested, if it exists
      def configuration(id, options={})
        enhance( get("configs/#{id}", options), with: ConfigurationMethods )
      end

      # Search configurations
      #
      # @param search_term [String] The term to search for
      # @return [Array] A list of configurations matching the search term
      def search_configurations(search_term, options={})
        enhance( get("configs?q=#{search_term}", options), with: ConfigurationMethods )
      end

      # Create a configuration
      #
      # @param name [String] Name of the configuration
      # @options options [Hash] :data JSON data of the config
      # @options options [Array] :imeis list of assets concerned by this configuration
      # @return [Field] Your newly created configuration
      def create_configuration(name, options={})
        enhance( post("configs", options.merge({:name => name})), with: ConfigurationMethods )
      end

      # Update a configuration
      #
      # @param id [String] Id of the configuration
      # @options options [String] Name of the configuration
      # @options options [Hash] :data JSON data of the config
      # @options options [Array] :imeis list of assets concerned by this configuration
      # @return [Field] Your newly created configuration
      def update_configuration(id, options={})
        enhance( put("configs/#{id}", options.merge({:name => name})), with: ConfigurationMethods )
      end

      # Get all configurations
      #
      # @return [Array] A list of all configurations
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
