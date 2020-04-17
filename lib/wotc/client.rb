module WOTC
  # Wrapper for the WOTC REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in https://sandbox.wotc.com/portal/api/documentation
  # @see https://sandbox.wotc.com/portal/api/documentation
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{ |f| require f }

    include WOTC::Client::Employees
    include WOTC::Client::Applicants
    include WOTC::Client::Companies
    include WOTC::Client::Documents
    include WOTC::Client::Payrolls
    include WOTC::Client::Locations
    include WOTC::Client::Webhooks
    include WOTC::Client::Users
    include WOTC::Client::Registers
    include WOTC::Client::Wotcs
    include WOTC::Client::Utils
  end
end