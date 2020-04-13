module WOTC
  class Client
    # Defines methods related to locations
    module Locations
      # Get all locations
      def all_locations
        get("locations")
      end

      def create_location(options={})
        post("locations", options)
      end

      def update_location(options={})
        put("locations", options)
      end

      def delete_location(location_id)
        delete("locations/#{location_id}")
      end
    end
  end
end