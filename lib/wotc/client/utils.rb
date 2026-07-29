module WOTC
  class Client
    # Defines methods related to utils
    module Utils

      # Ask wotc.com whether our access token is still accepted.
      #
      # Returns :valid, :revoked or :unknown.
      #
      # Only a 401 means revoked. A 403, a 5xx, a timeout or a body we cannot
      # read means we could not tell, and callers must not treat that as
      # revocation.
      def token_state
        body = get('user').body
        return :valid if body.is_a?(Hash) && !body['id'].nil?

        :unknown
      rescue WOTC::Unauthorized
        :revoked
      rescue StandardError
        :unknown
      end

      # Kept for compatibility. Prefer #token_state: this collapses "revoked"
      # and "could not tell" into the same false.
      def token_valid?
        token_state == :valid
      end

      # Pre-qualify an application of WOTC status
      def wotc_calculator(options={})
        result = post('wotc/calculator', options)
        result.body == true
      end
    end
  end
end
