module CloudConnect
  module Fields

    # Retrieve a list of fields.
    # WARNING: This method uses calls not officially supported by Mobile Devices.
    #
    # @return [[Hashie::Mash]] Array of Fields
    def fields(reload = false)
      return @fields if @fields && !reload
      page  = 1
      limit = 100
      fields = []
      while (slice = connection.get(connection.build_url("fields", :per_page => limit, :page => page)).body).size > 0
        page += 1
        fields += slice.map!{|hash| hash.values.first} if slice.size > 0
        slice.size < limit ? break : sleep(1)
      end
      @fields = fields.sort_by(&:id)
    end
  end
end
