module WOTC
  class Client
    module Registers

      # Register for an account and get back a life time access token.
      def register(options = {})
        response = post("register", options)
        if response.body.is_a?(Hash) && response.body["token"]
          return response
        else
          # raise error when token is missing.
          raise WOTC::BadRequest.new(response)
        end
      end
    end
  end
end