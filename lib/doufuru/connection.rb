# encoding: utf-8

require "faraday"
require "doufuru/response"
require "doufuru/response/mashify"
require "doufuru/response/jsonize"
require "doufuru/response/helpers"
require "doufuru/response/raise_error"
require "doufuru/request/oauth2"
require "doufuru/request/jsonize"

module Doufuru
  module Connection

    extend self

    include Doufuru::Constants

    def default_options(options)
      {
        :headers => {
          ACCEPT_CHARSET   => "utf-8",
          USER_AGENT       => user_agent,
        },
        :ssl => { :verify => false },
        :url => options.fetch(:endpoint) { Doufuru.endpoint }
      }.merge(options)
    end

    # Default middleware stack that uses default adapter as specified at
    # configuration stage.
    #
    def default_middleware(options={})
      Proc.new do |builder|
        builder.use Doufuru::Request::Jsonize
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        #builder.use Doufuru::Request::OAuth2, oauth_token if oauth_token?

        builder.use Faraday::Response::Logger if ENV['DOUFURU_DEBUG']
        builder.use Doufuru::Response::Helpers
        if !options[:raw]
          builder.use Doufuru::Response::Mashify
          builder.use Doufuru::Response::Jsonize
        end
        builder.use Doufuru::Response::RaiseError
        builder.adapter adapter
      end
    end

    @connecn = nil

    @stack = nil

    def clear_cache
      @connection = nil
    end

    def caching?
      @connection.nil?
    end

    # Exposes middleware builder to facilitate custom stacks and easy
    # addition of new extensions such as cache adapter.
    #
    def stack(options={}, &block)
      @stack ||= begin
        if block_given?
          Faraday::Builder.new(&block)
        else
          Faraday::Builder.new(&default_middleware(options))
        end
      end
    end

    # Returns a Fraday::Connection object
    #
    def connection(options = {})
      conn_options = default_options(options)
      clear_cache if !options.empty?
      puts "OPTIONS:#{conn_options.inspect}" if ENV["DOUFURU_DEBUG"]

      @connection ||= Faraday.new(conn_options.merge(:builder => stack(options)))
    end

  end
end
