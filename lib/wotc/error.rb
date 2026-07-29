module WOTC
  # Custom error class for rescuing from all wotc.com errors
  class Error < StandardError
    attr_reader :http_method, :url, :errors

    def initialize(response)
      @response = response.dup
      env = response.env
      # Use hash-style access for :method to avoid calling Kernel#method.
      # Plain Ruby only: this gem does not depend on ActiveSupport.
      http_method = env[:method].to_s.upcase
      @http_method = http_method.empty? ? "UNKNOWN" : http_method
      @url = env.url.to_s
      @status = response.status
      @body = response.body
      if @body.is_a?(Hash) && !@body.empty? && !@body.fetch("errors", nil).nil?
        @raw_errors = @body.fetch("errors")
      end
      super()
    end

    def message
      <<-HEREDOC
      URL: #{@url}
      method: #{@http_method}
      response status: #{@status}
      response body: #{@body}
      HEREDOC
    end

    def raw_errors
      @raw_errors
    end

    def error_sentence
      return if @raw_errors.nil?

      array = []
      @raw_errors.each do |_, v| 
        array += v
      end

      array.join(' ')
    end
  end

  # Any 4xx we do not name below. Our request was not accepted.
  class ClientError < Error; end

  # Any 5xx we do not name below. wotc.com could not answer. Retryable.
  class ServerError < Error; end

  # Raised when wotc.com returns the HTTP status code 400
  class BadRequest < ClientError; end

  # Raised when wotc.com returns the HTTP status code 401. This is the only
  # status that means our access token was rejected.
  class Unauthorized < ClientError; end

  # Raised when wotc.com returns the HTTP status code 403. Distinct from 401:
  # the token authenticated, the action was refused, often because the resource
  # does not exist or does not belong to this account.
  class Forbidden < ClientError; end

  # Raised when wotc.com returns the HTTP status code 404
  class NotFound < ClientError; end

  # Raised when wotc.com returns the HTTP status code 422
  class UnprocessableEntity < ClientError; end

  # Raised when wotc.com returns the HTTP status code 429
  class TooManyRequests < ClientError; end

  # Raised when wotc.com returns the HTTP status code 500
  class InternalServerError < ServerError; end

  # Raised when wotc.com returns the HTTP status code 502
  class BadGateway < ServerError; end

  # Raised when wotc.com returns the HTTP status code 503
  class ServiceUnavailable < ServerError; end

  # Raised when wotc.com returns the HTTP status code 504
  class GatewayTimeout < ServerError; end

  # Raised when client code fails to provide required parameters — before any
  # HTTP request exists. Unlike every class above it carries a plain message,
  # not a Faraday::Response, so it cannot inherit Error#initialize.
  class MissingRequiredArgument < StandardError; end
end
