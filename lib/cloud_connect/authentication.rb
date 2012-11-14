module CloudConnect
  module Authentication
    def authentication
      if token
        {:token => token}
      else
        {}
      end
    end

    def authenticated?
      !authentication.empty?
    end
  end
end
