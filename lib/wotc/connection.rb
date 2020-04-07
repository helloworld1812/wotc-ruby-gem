require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module WOTC
  module Connection
    private

    def connection(raw=false)
      options = {
        headers: {
          Accept: "application/#{format}; charset=utf-8",
          'User-Agent': user_agent
        },
        proxy: proxy,
        url: endpoint
      }.merge(connection_options)

      Faraday::Connection.new(options) do |conn|
        conn.authorization :Bearer,
      end
    end
  end
end

