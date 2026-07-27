require 'faraday'

module FaradayMiddleWare
  class RaiseHttpException < Faraday::Middleware
    def initialize(app)
      super(app)
    end

    def call(env)
      response = @app.call(env)
      response.on_complete do |_env|
        error = error_class(response.status.to_i)
        raise error.new(response) if error
      end
    end

    private

    # Every 4xx and 5xx raises. The named statuses get their own class; anything
    # else falls back to ClientError or ServerError, so a status we have not
    # thought about can never be mistaken for a successful response.
    def error_class(status)
      case status
      when 400 then WOTC::BadRequest
      when 401 then WOTC::Unauthorized
      when 403 then WOTC::Forbidden
      when 404 then WOTC::NotFound
      when 422 then WOTC::UnprocessableEntity
      when 429 then WOTC::TooManyRequests
      when 500 then WOTC::InternalServerError
      when 502 then WOTC::BadGateway
      when 503 then WOTC::ServiceUnavailable
      when 504 then WOTC::GatewayTimeout
      when 400..499 then WOTC::ClientError
      when 500..599 then WOTC::ServerError
      end
    end
  end
end
