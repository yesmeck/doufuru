# encoding: utf-8

require "faraday"
require "doufuru/utils/url"

module Doufuru
  module Request
    class OAuth2 < Faraday::Middleware

      include Doufuru::Utils::Url

      AUTH_HEADER  = "Authorization".freeze

      dependency "oauth2"

      def call(env)
        env[:request_headers].merge!(AUTH_HEADER => "Bearer #{@token}")
        @app.call env
      end

      def initialize(app, *args)
        super app
        @app = app
        @token = args.shift
      end

    end
  end
end
