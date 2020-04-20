require 'faraday'

module FaradayMiddleWare
  class RaiseHttpException < Faraday::Middleware
    def initialize(app)
      super(app)
    end

    def call(env)
      @app.call(env).on_complete do |response|
        case response.status.to_i
        when 400
          raise WOTC::BadRequest.new(response)
        when 401
          raise WOTC::Unauthorized.new(response)
        when 404
          raise WOTC::NotFound.new(response)
        when 500
          raise WOTC::InternalServerError.new(response)
        when 502
          raise WOTC::BadGateway.new(response)
        when 503
          raise WOTC::ServiceUnavailable.new(response)
        when 504
          raise WOTC::GatewayTimeout.new(response)
        end
      end
    end
  end
end