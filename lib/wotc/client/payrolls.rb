module WOTC
  class Client
    # Defines methods related to payrolls.
    module Payrolls
      # Get as list of hours and wages
      def all_payrolls(options={})
        paginate("hours-wages")
      end

      # Create a payroll record
      def create_payroll(options={})
        post("hours-wages", options)
      end

      # THIS API IS UNSTABLE!
      # Get as list of hours and wages by employee record
      # def employee_payrolls(employee_id, options={})
      #   get("employees/#{employee_id}/hours-wages")
      # end

      # Update a payroll record
      def update_payroll(payroll_id, options={})
        put("hours-wages/#{payroll_id}")
      end

    end
  end
end