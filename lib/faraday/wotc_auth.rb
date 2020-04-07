require 'faraday'

module FaradayMiddleware
  class WotcAuth < Faraday::Middleware
    def call(env)
      if @access_token
        env[:request_headers] = env[:request_headers].merge(Authorization: "Bearer #{@access_token}")
      end

      @app.call env
    end
  end
end