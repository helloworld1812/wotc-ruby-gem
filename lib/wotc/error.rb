module WOTC
  # Custom error class for rescuing from all wotc.com errors
  class Error < StandardError; end

  # Raised when wotc.com returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when wotc.com returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when wotc.com returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when wotc.com returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when wotc.com returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when wotc.com returns the HTTP status code 504
  class GatewayTimeout < Error; end

  # Raised when client fails to provide required parameters.
  class MissingRequiredArgument < Error; end
end