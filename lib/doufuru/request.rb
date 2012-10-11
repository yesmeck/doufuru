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

    def delete(path, params = {}, raw = false)
      request(:delete, path, params, raw)
    end

    def request(method, path, params, raw)
      path.sub!(/^\//, '')
      if path =~ /^shuo/
        path.sub!(/^shuo/, "shuo/v2")
      else
        path = "v2/#{path}"
      end
      response = connection(raw).send(method) do |request|
        request.headers["Authorization"] = "Bearer #{access_token}" if oauthed?
        case method
        when :get, :delete
          request.url(path, params)
        when :post, :put
          request.path = path
          request.body = params
        end
      end

      response.body
    end
  end
end
