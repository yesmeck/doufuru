# encoding: utf-8

module Doufuru
  module Request
    def get(path, options = {}, raw = false)
      request(:get, path, options, raw)
    end

    def post(path, params = {}, raw = false)
      request(:post, path, params, raw)
    end

    def request(method, path, options, raw)
      response = connection(raw).send(method) do |request|
        request.headers["Authorization"] = "Bearer #{access_token}" if oauthed?
        case method
        when :get
          request.url(path, options)
        when :post
          request.path = path
          request.body = options
        end
      end

      if raw
        response
      else
        response.body
      end
    end
  end
end
