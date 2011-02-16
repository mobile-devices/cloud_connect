module CloudConnect
  module Messages

    # Returns all messages that match parameters provided in +opts+ list
    # (if +opts+ is provided)
    #
    # @param [Hash] opts the options to filter the messages.
    # @option opts [String] :ret ('id, time') Select attributes to fetch
    # @option opts [String] :channelids List of channel ids
    # @option opts [String] :messageids List of message ids
    # @option opts [String] :unitids List of unit ids
    # @option opts [String] :userids List of user ids
    # @option opts [String] :status Message status
    #   (0 (new), 1 (sent), 2 (received), 3 (failed))
    # @option opts [String] :timedout (false) Include timed-out messages
    # @option opts [String] :from Minimum date
    # @option opts [String] :to Maximum date
    # @option opts [String] :direction Message direction
    #   (unittouser or usertounit)
    # @option opts [String] :replyto List of reference message ids
    # @option opts [Integer] :id_min Minimum ID
    # @option opts [Integer] :id_max Maximum ID
    # @option opts [Integer] :limit (25) Number of elements to fetch
    # @return [Array<Hashie::Mash>] Messages
    # @see http://develop.g8teway.com/p/messages.html#listing_messages
    def messages(opts = {})
      messages = connection.get(connection.build_url("messages", opts)).body
      messages.map!{|hash| hash.values.first}
    end

    # Send a message to a specific device
    #
    # @param [Integer] unit
    # @param [Integer] channel
    # @param [String] content
    # @param [Hash] opts
    # @return [Hashie::Mash] The message
    # @see http://develop.g8teway.com/p/messages.html#sending_a_new_message
    def send_message(unit, channel, content, opts = {})
      # TODO: rename #message_create ?
      opts.merge! :channelid => channel, :unitid => unit, :content => content
      response = connection.post do |req|
        req.url 'messages'
        req.body = {:message => opts}
      end
      response.body.values.first
    end
  end
end
