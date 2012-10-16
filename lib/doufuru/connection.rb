# encoding: utf-8

require "faraday_middleware"

module Doufuru
  module Connection
    private

    def connection(raw = false)
      options = {
        :ssl => { :verify => false },
        :url => Doufuru.api_url,
      }

      connection = Faraday.new(options) do |builder|
        builder.request :multipart
        builder.request :url_encoded
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
