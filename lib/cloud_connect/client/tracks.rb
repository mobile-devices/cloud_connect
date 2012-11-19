module CloudConnect
  class Client
    module Tracks

      # Get a track
      #
      # @param id [String] ID of the track
      # @return [Track] The track you requested, if it existsle ||
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0004-tracks
      # @example Get track 0123456789012345
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.track("0123456789012345")
      def track(id, options={})
        enhance( get("tracks/#{id}", options), with: TrackMethods )
      end

      # Search tracks
      #
      # @param search_term [String] The term to search for
      # @return [Array] A list of tracks matching the search term
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0004-tracks
      # @example Search for '123' in the tracks
      #   @client = CloudConnect::Client.new(:account => 'foor', :token => 'bar')
      #   @client.search_tracks
      def search_tracks(search_term, options={})
        enhance( get("tracks?q=#{search_term}", options), with: TrackMethods )
      end

      # Get tracks
      #
      # @return [Array] A list of all tracks
      # @see http://wordsabout.it/mobile-devices/cloudconnect-user-documentation/cc-0004-messages
      # @example List all tracks
      #   @client = CloudConnect::Client.new(:account => 'foo', :token => 'bar')
      #   @client.tracks
      def tracks(options={})
        enhance( get("tracks", options), with: TrackMethods )
      end

      alias :list_tracks :tracks
      module TrackMethods
        extend CustomMethods
      end
    end
  end
end