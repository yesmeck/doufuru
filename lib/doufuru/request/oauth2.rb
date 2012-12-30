# encoding: utf-8

require "faraday"
require "doufuru/utils/url"

module Doufuru
  module Request
    class OAuth2 < Faraday::Middleware
      include Doufuru::Utils::Url

      ACCESS_TOKEN = 'access_token'.freeze
      AUTH_HEADER  = 'Authorization'.freeze

      dependency 'oauth2'

      def call(env)
        # Extract parameters from the query
        params = { ACCESS_TOKEN => @token }.update query_params(env[:url])

        if token = params[ACCESS_TOKEN] and !token.empty?
          env[:url].query = build_query params
          env[:request_headers].merge!(AUTH_HEADER => "Token token=\"#{token}\"")
        end

        @app.call env
      end

      def initialize(app, *args)
        super app
        @app = app
        @token = args.shift
      end

      def query_params(url)
        if url.query.nil? or url.query.empty?
          {}
        else
          parse_query url.query
        end
      end
    end
  end
end
