module WOTC
  class Client
    # Defines methods related to employees.
    module Employees
      # Fetch all employees
      def employees(options={})
        paginate("employees", options)
      end

      # Get a single employee
      def employee(employee_id)
        get("employees/#{employee_id}")
      end

      # Update an employee
      def update_employee(employee_id, options={})
        put("employees/#{employee_id}", options)
      end

      # Create an employee
      def create_employee(options={})
        post("employees", options)
      end

      # Get employee's WOTC status
      def employee_wotc_status(employee_id)
        get("employees#{employee_id}/wotc/status")
      end

      # Get wotc info for specific employee
      def employee_wotc_info(employee_id)
        get("employees/#{employee_id}/wotc")
      end

      # Generate an auto fill WOTC url
      def employee_auto_fill_wotc_url(employee_id, redirect=nil)
        uri = URI.parse(redirect) rescue false
        result = if uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
          get("employees/#{employee_id}/wotc/url?redirect=#{redirect}")
        else
          get("employees/#{employee_id}/wotc/url")
        end

        return result.body["url"]
      end

      # Get employees with certified WOTC status
      def certified_employees(company_id=nil)
        if company_id.nil?
          get("employees/wotc/certified")
        else
          get("employees/wotc/certified?company_id=#{company_id}")
        end
      end
    end
  end
end