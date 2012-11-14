module CloudConnect
  class Client
    module Fields
      # Get a field
      #
      # @param name [String] Name of the field
      # @return [Field] The field you requested, if it exists
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0006-fields
      # @example Get field 0123456789012345
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.field("0123456789012345")
      def field(name, options={})
        enhance( get("fields/#{name}", options), with: FieldMethods )
      end
  
      # Get fields
      #
      # @return [Array] A list of all fields
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0006-fields
      # @example List all fields
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.fields
      def fields(options={})
        enhance( get("fields", options), with: FieldMethods )
      end
      alias :list_fields :fields
  
      # Create a field
      #
      # @param name [String] Name of the field
      # @param options [Hash] A customizable set of options
      # @options options [Integer] :field ID of the field
      # @options options [String] :field_type Type of the field: <tt>unknown</tt>, <tt>boolean</tt>, <tt>integer</tt>, <tt>decimal</tt>, <tt>string</tt>, or <tt>base64</tt>
      # @options options [String] :size Size of the field
      # @options options [String] :ack
      # @options options [String] :description Description of the field
      # @return [Field] Your newly created field
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0006-fields#create_a_new_field
      # @example Create a new Field
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.create_field("CUSTOM_SENSOR_TEMP", :field_type => 'integer', :size => 1, :description => "Custom sensor temp in Celsius")
      def create_field(name, options={})
        enhance( post("fields", options.merge({:name => name})), with: FieldMethods )
      end
  
      # Delete a single field
      #
      # @param name [String] Name fo the field
      # @return [Response] A response object with status
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0006-fields#delete_a_field
      # @example Delete the CUSTOM_SENSOR_TEMP field
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.delete_field("CUSTOM_SENSOR_TEMP")
      def delete_field(name, options={})
        delete("fields/#{name}", options, true)
      end
  
      module FieldMethods
        extend CustomMethods
      end
    end
  end
end
