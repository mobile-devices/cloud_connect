require 'cloud_connect/authentication'
require 'cloud_connect/connection'
require 'cloud_connect/request'

require 'cloud_connect/client/custom_methods'
require 'cloud_connect/client/assets'
require 'cloud_connect/client/fields'
require 'cloud_connect/client/channels'
require 'cloud_connect/client/tracks'
require 'cloud_connect/client/messages'
require 'cloud_connect/client/notification'

module CloudConnect
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = CloudConnect.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def enhance(object, with_opts)
      # @private
      # Add custom methods to provided object(s).
      # This method provides syntaxic suggar upon <tt>Module.apply_to(object)</tt>,
      # allowing you to write <tt>enhance object, with: Module</tt>
      #
      # @param object [Object] An Object or Array of Objects to enhance.
      # @param with_opts [Hash] Customizable set of options.
      # @options with_opts [Module] :with Module to include.
      # @return [Object] Enhanced initial object.
      # @example Enhance an instance of Hashie::Mash with methods defined in the AssetMethods module
      #   enhance( Hashie::Mash.new, :with => AssetMethods)
      object.tap do |obj|
        with_opts[:with].apply_to(obj, client: self)
      end
    end

    include CloudConnect::Authentication
    include CloudConnect::Connection
    include CloudConnect::Request

    include CloudConnect::Client::Assets
    include CloudConnect::Client::Fields
    include CloudConnect::Client::Channels
    include CloudConnect::Client::Tracks
    include CloudConnect::Client::Messages
    include CloudConnect::Client::Notification
  end
end
