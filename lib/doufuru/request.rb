# encoding: utf-8

module Doufuru
  module Request
    def get(path, params = {}, raw = false)
      request(:get, path, params, raw)
    end

    def post(path, params = {}, raw = false)
      request(:post, path, params, raw)
    end

    def put(path, params = {}, raw = false)
      request(:put, path, params, raw)
    end

    def request(method, path, params, raw)
      response = connection(raw).send(method) do |request|
        request.headers["Authorization"] = "Bearer #{access_token}" if oauthed?
        case method
        when :get
          request.url(path, params)
        when :post, :put
          request.path = path
          request.body = params
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
