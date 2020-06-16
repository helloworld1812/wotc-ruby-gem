module WOTC
  class Client
    # Defines methods related to utils
    module Utils

      # Trigger an api call to verify access_token is valid.
      def token_valid?
        user = get('user').body
        return true if user&.fetch("id")
      rescue => e
        return false
      end
      
      # Pre-qualify an application of WOTC status
      def wotc_calculator(options={})
        result = post('wotc/calculator', options)
        result.body == true
      end
    end
  end
end