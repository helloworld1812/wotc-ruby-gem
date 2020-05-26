require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module WOTC
  module Connection

    private

    def connection
      options = {
        headers: {
          "Accept" => "application/#{format}; charset=utf-8",
          "User-Agent" => user_agent,
        },
        proxy: proxy,
        url: endpoint
      }.merge(connection_options)

      Faraday::Connection.new(options) do |conn|
        conn.authorization :Bearer, access_token
        # https://github.com/lostisland/faraday/issues/417#issuecomment-223413386
        # conn.options[:timeout] = 10 # TODO: move it to configuration
        # conn.options[:open_timeout] = 5 # TODO: move it to configuration
        conn.request :json

        conn.use FaradayMiddleWare::RaiseHttpException
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end
  end
end

