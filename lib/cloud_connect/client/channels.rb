module CloudConnect
  module Channels

    # Retrieve list of channels
    # WARNING: This method uses calls not officially supported by Mobile Devices.
    #
    # @return [Array of Hashie::Mash] Channels
    def channels(reload = false)
      return @channels if @channels && !reload
      page  = 1
      limit = 100
      channels = []
      while (slice = connection.get(connection.build_url("channels", :per_page => limit, :page => page)).body).size > 0
        page += 1
        channels += slice.map!{|hash| hash.values.first} if slice.size > 0
        slice.size < limit ? break : sleep(1)
      end
      @channels = channels.sort_by(&:channel)
    end

  end
end
