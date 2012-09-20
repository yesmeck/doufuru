# encoding: utf-8

module Doufuru
  module Request
    def get(path, options = {}, raw = false)
      request(:get, path, options, raw)
    end

    def request(method, path, options, raw)
      response = connection(raw).send(method) do |request|
        case method
        when :get
          request.headers["Authorization"] = "Bearer #{access_token}" if oauthed?
          request.url(path, options)
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
