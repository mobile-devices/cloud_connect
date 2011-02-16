# From active_support
#
# http://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/module/delegation.rb
# http://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/module/remove_method.rb
class Module

  # Used by delegate
  # @see http://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/module/remove_method.rb
  def remove_possible_method(method)
      remove_method(method)
    rescue NameError
  end

  # Provides a delegate class method to easily expose contained objects' methods
  # as your own. Pass one or more methods (specified as symbols or strings)
  # and the name of the target object via the <tt>:to</tt> option (also a symbol
  # or string). At least one method and the <tt>:to</tt> option are required.
  # @see http://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/module/delegation.rb
  def delegate(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, :to => :greeter)."
    end

    if options[:prefix] == true && options[:to].to_s =~ /^[^a-z_]/
      raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
    end

    prefix = options[:prefix] && "#{options[:prefix] == true ? to : options[:prefix]}_" || ''

    file, line = caller.first.split(':', 2)
    line = line.to_i

    methods.each do |method|
      on_nil =
        if options[:allow_nil]
          'return'
        else
          %(raise "#{self}##{prefix}#{method} delegated to #{to}.#{method}, but #{to} is nil: \#{self.inspect}")
        end

      module_eval(<<-EOS, file, line - 5)
        if instance_methods(false).map(&:to_s).include?("#{prefix}#{method}")
          remove_possible_method("#{prefix}#{method}")
        end

        def #{prefix}#{method}(*args, &block)               # def customer_name(*args, &block)
          #{to}.__send__(#{method.inspect}, *args, &block)  #   client.__send__(:name, *args, &block)
        rescue NoMethodError                                # rescue NoMethodError
          if #{to}.nil?                                     #   if client.nil?
            #{on_nil}                                       #     return # depends on :allow_nil
          else                                              #   else
            raise                                           #     raise
          end                                               #   end
        end                                                 # end
      EOS
    end
  end
end
