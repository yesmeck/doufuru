require 'doufuru/response/raise_error'
require 'doufuru/version'

module Doufuru

  # Default configuration options for {Client}
  module Default
    # Default API endpoint
    API_ENDPOINT = 'https://api.douban.com/v2'.freeze

    # Default User Agent header string
    USER_AGRENT = "Doufuru Ruby gem #{Doufuru::VERSION}".freeze

    # Default media type
    MEDIA_TYPE = 'application/json'.freeze

    # Default web endpoint
    WEB_ENDPOINT = 'http://www.douban.com'.freeze

    # Default Faraday middleware stack
    MIDDLEWARE = Faraday::Builder.new do |builder|
      builder.use Doufuru::Response::RaiseError
      builder.adapter Faraday.default_adapter
    end

    class << self

      # Configution options
      #
      # @return [Hash]
      def options
        Hash[Doufuru::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # Default access token from ENV
      #
      # @return [String]
      def access_token
        ENV['DOUFURU_ACCESS_TOKEN']
      end

      # Default API endpoint from ENV or {API_ENDPOINT}
      #
      # @return [String]
      def api_endpoint
        ENV['DOUFURU_API_ENDPOINT'] || API_ENDPOINT
      end

      # Default pagination prefrence ftom ENV
      #
      # @return [String]
      def auto_paginate
        ENV['DOUFURU_AUTO_PAGINATE']
      end

      # Default OAuth app key from ENV
      #
      # @return [String]
      def client_id
        ENV['DOUFURU_CLIENT_ID']
      end


      # Default OAuth app secret from ENV
      #
      # @return [String]
      def client_secret
        ENV['DOUFURU_CLIENT_SECRET']
      end

      # Default media type from ENV or {MEDIA_TYPE}
      #
      # @return [String]
      def default_media_type
        ENV['DOUFURU_DEFAULT_MEDIA_TYPE'] || MEDIA_TYPE
      end

      # Default Douban username from ENV
      #
      # @return [String]
      def login
        ENV['DOUFURU_LOGIN']
      end

      # Default middleware stack for Faraday::Connection from {MIDDLEWARE}
      #
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

      # Default pagination page size from ENV
      #
      # @return [Fixnum]
      def per_page
        page_size = ENV['DOUFURU_PER_PAGE']
        page_size.to_i if page_size
      end

      # Default proxy server URI for Faraday connection from ENV
      #
      # @return [String]
      def proxy
        ENV['DOUFURU_PROXY']
      end

      # Defalt User-Agent header string from ENV or {USER_AGRENT}
      #
      # @return [String]
      def user_agent
        ENV['DOUFURU_USER_AGENT'] || USER_AGRENT
      end

      # Default web endpoint from ENV or {WEB_ENDPOINT}
      #
      # @return [String]
      def web_endpoint
        ENV['DOUFURU_WEB_ENDPOIENT'] || WEB_ENDPOINT
      end

      # Default options for Faraday::Connection
      def connection_options
        {
          headers: {
            accpet: default_media_type,
            user_agent: user_agent
          }
        }
      end

    end
  end

end
