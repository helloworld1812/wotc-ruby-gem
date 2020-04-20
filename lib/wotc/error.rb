module WOTC
  # Custom error class for rescuing from all wotc.com errors
  class Error < StandardError
    attr_reader :http_method, :url, :errors

    def initialize(response)
      super
      @response = response.dup
      @http_method = response.method.to_s
      @url = response.url
      if response.body.is_a?(Hash) && !response.body.empty? && !response.body.fetch("errors").nil?
        @raw_errors = response.body.fetch("errors")
      end
    end

    def message
      <<-HEREDOC
      URL: #{env.url}
      method: #{env.method}
      response status: #{env.status}
      response body: #{env.response.body}
      HEREDOC
    end

    def raw_errors
      @raw_errors
    end
  end

  # Raised when wotc.com returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when wotc.com returns the HTTP status code 401
  class Unauthorized < Error; end

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