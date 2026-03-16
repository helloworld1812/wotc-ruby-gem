module WOTC
  # Custom error class for rescuing from all wotc.com errors
  class Error < StandardError
    attr_reader :http_method, :url, :errors

    def initialize(response)
      @response = response.dup
      env = response.env
      # Use hash-style access for :method to avoid calling Kernel#method
      @http_method = env[:method].to_s.upcase.presence || "UNKNOWN"
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
