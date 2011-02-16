module CloudConnect
  module Trackings

    # Retrieve list of tracking data
    #
    # @see http://develop.g8teway.com/p/tracking_records.html#listing_tracking_records
    # @param [Hash] opts the options to filter the tracking data.
    # @options opts [String] :ret Select attributes to fetch
    # @options opts [String] :userids List of unit ids
    # @options opts [String] :fieldids List of field ids
    # @options opts [Integer] :from Minimum ID
    # @options opts [Integer] :to Maximum ID
    # @options opts [Integer] :id_min Minimum ID
    # @options opts [Integer] :id_max Maximum ID
    # @options opts [Integer] :limit Number of elements to fetch (default 25
    # @return [Array of Hashie::Mash] Tracking data
    def trackings(opts = {})
      trackings = connection.get(connection.build_url("tracking_records", opts)).body
      trackings.map!{|hash| hash.values.first}
    end
  end
end
