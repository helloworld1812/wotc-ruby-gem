module WOTC
  class Client
    # Defines methods related to users.
    module Users

      # Get authorized user information.
      def current_user
        get('user')
      end
    end
  end
end