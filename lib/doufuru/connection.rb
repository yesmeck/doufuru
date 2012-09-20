# encoding: utf-8

require "faraday_middleware"

module Doufuru
  module Connection
    private

    def connection(authenticate = true, raw = false)
      options = {
        :ssl => { :verify => false },
        :url => Doufuru.api_url,
      }

      connection = Faraday.new(options) do |builder|
        builder.request :json
        unless raw
          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson
        end
        builder.adapter Faraday.default_adapter
      end
      connection
    end
  end
end
