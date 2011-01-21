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
    end

    # Return information about a specific unit
    #
    # @param [String] unit_id Unit ID
    # @return [Hashie::Mash] User info
    def unit(unit_id=nil)
      connection.get("/units/#{unit_id}").body
    end

  end
end
