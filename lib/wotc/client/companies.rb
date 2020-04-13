module WOTC
  class Client
    # Defines methods related to companies
    module Companies

      # Get company settings, if there are no settings saved, anempty response if given.
      def get_company_settings(company_id=nil)
        if company_id.nil?
          get("company/settings")
        else
          get("company/settings/?company_id=#{company_id}")
        end
      end

      # Update company settings
      def update_company_settings(company_id=nil, options={})
        if company_id.nil?
          put("company/settings", options)
        else
          put("company/settings?company_id=#{company_id}", options)
        end
      end
    end
  end
end