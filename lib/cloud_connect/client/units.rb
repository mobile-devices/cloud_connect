module CloudConnect
  module Units

    # Returns all units that match parameters provided in +opts+ list
    # (if +opts+ is provided)
    #
    # @param [Hash] opts the options to filter the units.
    # @option opts [String] :ret ('id, lat, long, time') Select attributes to fetch
    # @option opts [String] :unitids List of unit ids
    # @option opts [String] :fieldids List of field ids
    # @option opts [String] :unknow Allow unknown position
    # @option opts [Integer] :id_min Minimum ID
    # @option opts [Integer] :id_max Maximum ID
    # @option opts [Integer] :limit Number of elements to fetch (default 25
    # @return [Array<Hashie::Mash>] Units
    # @see http://develop.g8teway.com/p/units.html#listing_units
    def units(opts = {})
      units = connection.get(connection.build_url("units", opts)).body
      units.map!{|hash| hash.values.first}
      units.each{|u| u.extend UnitHelper; u._cloud_connect = self;}
    end

    # Search for a specific unit knowing it's modid
    #
    # @param [String] modids the comma separated list modids.
    #   Partial modids can be provided using the '*' caracter
    # @example
    #   find_unit("*3216*")
    # @return [Array<Hashie::Mash>] Unit
    # @see http://develop.g8teway.com/p/units.html#searching_units
    def find_units(modids)
      # TODO: Rename unit_search?
      units = connection.get(connection.build_url("units/search", :modids => modids)).body
      units.map!{|hash| hash.values.first}
      units.each{|u| u.extend UnitHelper; u._cloud_connect = self;}
    end

    # Return information about a specific unit
    #
    # @param [String] unit_id Unit ID
    # @param [Hash] opts the options to filter the units.
    # @option opts [String] :ret ('id, lat, long, time') Select attributes to fetch
    # @option opts [String] :fieldids List of field ids
    # @option opts [String] :unknow Allow unknown position
    # @return [Hashie::Mash] Unit info
    def unit(unit_id=nil, opts = {})
      units = connection.get(connection.build_url("units", opts.merge(:unitids => unit_id))).body
      units.map!{|hash| hash.values.first}
      units.each{|u| u.extend UnitHelper; u._cloud_connect = self;}
      units.first
    end

    module UnitHelper
      attr_accessor :_cloud_connect

      # Return the last known location of a specific unit
      #
      # @return [Integer lat, Integer long] Latitude, Longitude
      def location
        [lat.to_f / 100_000, lng.to_f / 100_000]
      end

      # Send a message to the unit
      #
      # @param [Integer] channel
      # @param [String] content
      # @param [Hash] opts
      # @return [Hashie::Mash] The message
      # @see http://develop.g8teway.com/p/messages.html#sending_a_new_message
      def send_message(channel, content, opts = {})
        raise "Unknown unit id, try providing :ret => 'id' when fetching units from the API." unless id && id > 0
        _cloud_connect.send_message(id, channel, content, opts)
      end
    end
  end
end
