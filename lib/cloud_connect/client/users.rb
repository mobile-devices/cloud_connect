module CloudConnect
  module Users

    # Retrieve list of users
    #
    # @see http://develop.g8teway.com/p/users.html#searching_and_listing_users
    # @param [Hash] opts the options to filter the units.
    # @options opts [String] :ret Select attributes to fetch
    # @options opts [String] :userids List of unit ids
    # @options opts [String] :logins List of field ids
    # @options opts [Integer] :id_min Minimum ID
    # @options opts [Integer] :id_max Maximum ID
    # @options opts [Integer] :limit Number of elements to fetch (default 25
    # @return [Array of Hashie::Mash] Users
    def users(opts = {})
      opts.default! :ret => %w(id login email).join(',')
      users = connection.get(connection.build_url("users", opts)).body
      users.map!{|hash| hash.values.first}
    end
  end
end
