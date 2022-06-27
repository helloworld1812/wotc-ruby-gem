require 'base64'

module WOTC
  # Defines HTTP request methods
  module Request
    # HTTP GET request
    def get(path, options={})
      request(:get, path, options)
    end

    # HTTP POST request
    def post(path, options={})
      request(:post, path, options)
    end

    # HTTP PUT request
    def put(path, options={})
      request(:put, path, options)
    end

    # HTTP DELETE request
    def delete(path, options={})
      request(:delete, path, options)
    end

    private

    # Auto-pagination for HTTP get.
    # return all resources when auto_paginate is set true.
    # return just one page when auto_paginate is set false.
    def paginate(path, options={})
      per_page = options[:per_page] || options["per_page"] || @per_page
      page = options[:page] || options["page"]
      response = get(path+"?page=1&per_page=#{per_page}")

      # return one page results without pagination.
      return response if !@auto_paginate

      # return all results when enabled auto paginate
      last_response = response.dup
      data = response.body["data"]
      while last_response.body["next_page_url"]
        last_response = get(last_response.body["next_page_url"])
        data.concat(last_response.body["data"]) if last_response.body["data"].is_a?(Array)
      end

      return data
    end

    def request(method, path, options)
      response = connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(Addressable::URI.escape(path), options)
        when :post, :put
          request.path = Addressable::URI.escape(path)
          request.body = options
        end
      end

      response
    end
  end
end
