module CloudConnect
  class Client
    module Channels
      # Get a channel
      #
      # @param name [String] Name of the channel
      # @return [Channel] The channel you requested, if it exists
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0006-channels
      # @example Get channel 0123456789012345
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.channel("0123456789012345")
      def channel(name, options={})
        enhance( get("channels/#{name}", options), with: ChannelMethods )
      end
  
      # Get channels
      #
      # @return [Array] A list of all channels
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0003-channels
      # @example List all channels
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.channels
      def channels(options={})
        enhance( get("channels", options), with: ChannelMethods )
      end
      alias :list_channels :channels
  
      # Create a channel
      #
      # @param name [String] Name of the channel
      # @param options [Hash] A customizable set of options
      # @options options [Integer] :msgttl    The delay in seconds before the message is considered expired (and will not be sent)
      # @options options [Integer] :unitack   The delay in seconds for acknowledgment by the asset (after the message has been sent)
      # @options options [Integer] :serverack The delay in seconds for acknowledgment by the server (after the message has been sent)
      # @return [Channel] Your newly created channel
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0007-channels#create_a_new_channel
      # @example Create a new Channel
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.create_channel("weather")
      def create_channel(name, options={})
        enhance( post("channels", options.merge({:name => name})), with: ChannelMethods )
      end
  
      # Delete a single channel
      #
      # @param name [String] Name fo the channel
      # @return [Response] A response object with status
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0006-channels#delete_a_channel
      # @example Delete the CUSTOM_SENSOR_TEMP channel
      #   @client = CloudConnect::CloudConnect.new(:account => 'foo', :token => 'bar')
      #   @client.delete_channel("com.acmecorp.weather")
      def delete_channel(name, options={})
        delete("channels/#{name}", options, true)
      end
  
      module ChannelMethods
        extend CustomMethods
      end
    end
  end
end
