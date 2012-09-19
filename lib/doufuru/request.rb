# encoding: utf-8

module Doufuru
  module Request
    def get(path,  raw = false)
      request(:get, path, raw)
    end

    def request(method, path, raw)
      response = connection(raw).send(method) do |request|
        case method
        when :get
          request.url(path)
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
