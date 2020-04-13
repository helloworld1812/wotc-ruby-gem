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
          raise WOTC::BadRequest, error_message(env)
        when 404
          raise WOTC::NotFound, error_message(env)
        when 500
          raise WOTC::InternalServerError, error_message(env)
        when 502
          raise WOTC::BadGateway, error_message(env)
        when 503
          raise WOTC::ServiceUnavailable, error_message(env)
        when 504
          raise WOTC::GatewayTimeout, error_message(env)
        end
      end
    end

    private

    def error_message(env)
      "\nURL: #{env.url}\nmethod: #{env.method} \nstatus: #{env.status}\nerrors: #{env.response.body}"
    end
  end
end