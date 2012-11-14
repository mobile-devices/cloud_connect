module CloudConnect
  class Client
    module Tracks
      # Get tracks
      #
      # @return [Array] A list of all tracks
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0004-messages
      # @example List all tracks
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.tracks
      def messages(tracks={})
        enhance( get("tracks", options), with: TrackMethods )
      end
  
      alias :list_messages :messages
      module TrackMethods
        extend CustomMethods
      end
    end
  end
end
