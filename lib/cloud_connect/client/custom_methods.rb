module CustomMethods
  # @private
  def extended(base)
    # FIXME: Useless time consuming (especially for arrays)...
    base.class.send(:attr_accessor, :_client) unless base.respond_to?(:_client)
  end
  
  # @private
  # By extending CustomMethods in YourModule, you are able to call
  # YourModule.apply_to(object_or_array) to add YourModule methods to the
  # object or to all objects in the array.
  def apply_to(receiver, client_opts)
    case receiver
    when Array
      receiver.each{|a| a.extend self; a._client = client_opts[:client]}
    when Hashie::Mash
      receiver.extend self; receiver._client = client_opts[:client]
    end
  end
end
