module WOTC
  class Client
    module Registers

      # Register for an account and get back a life time access token.
      def register(options)
        post("register", options)
      end
    end
  end
end