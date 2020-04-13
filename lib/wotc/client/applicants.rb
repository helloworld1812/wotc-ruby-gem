module WOTC
  class Client
    # Defines methods related to applicants.
    module Applicants
      # Get as list of applicants
      def applicants(options={})
        paginate("applicants", options)
      end

      # Create an applicant
      def create_applicant(options)
        post('applicants', options)
      end

      # Update an applicant
      def update_applicant(applicant_id, options={})
        put("applicants/#{applicant_id}", options)
      end

      # TODO: boolean response
      # Delete an applicant
      def delete_applicant(applicant_id)
        delete("applicants/#{applicant_id}")
      end

      # Get as of applicants whose WOTC status has changed in the last 24 hours.
      # def recent_status_changed_applicants
      #   get("applicants/changes/wotc/status")
      # end
    end
  end
end