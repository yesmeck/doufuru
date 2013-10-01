require 'sawyer'
require 'doufuru/arguments'
require 'doufuru/configurable'
require 'doufuru/authentication'

module Doufuru

  # Client for the Douban API v2
  #
  # @see http://developers.douban.com/
  class Client

    include Doufuru::Authentication
    include Doufuru::Configurable

    attr_reader :last_response

    def initialize(options = {})
      Doufuru::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Doufuru.instance_variable_get(:"@#{key}"))
      end
    end

    # Compares client options to a Hash of requested options
    #
    # @param opts [Hash] Options to compare with current client options
    # @return [Boolean]
    def same_options?(opts)
      opts.hash == options.hash
    end

    # Text representation of the client
    #
    # @return [String]
    def inspect
      inspected = super
      inspected = inspected.gsub! @access_token, "#{'*'*36}#{@access_token[36..-1]}"
      inspected
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def get(url, options = {})
      request :get, url, parse_query_and_convenience_headers(options)
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def post(url, options = {})
      request :post, url, options
    end

    # Make a HTTP PUT request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def post(url, options = {})
      request :put, url, options
    end

    # Make a HTTP PATCH request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def post(url, options = {})
      request :patch, url, options
    end
    #
    # Make a HTTP DELETE request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def post(url, options = {})
      request :delete, url, options
    end

    # Make a HTTP HEAD request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def head(url, options = {})
      request :head, url, parse_query_and_convenience_headers(options)
    end

    # Make one ot more HTTP GET requests, optionally fetching
    # the nest page of results from URL in Link response header based
    # on value in {#auto_paginate}
    #
    # @param url [String] the pathm relative to {#api_endpoint}
    # @param options [Hash] Query and header params fot request
    # @return [Sawyer::Resource]
    def paginate(url, optopns = {})
      opts = parse_query_and_convenience_headers(options.dup)
      if @auto_paginate || @per_page
        opts[:query][:per_page] ||= @page || (@auto_paginate ? 50 : nil)
      end

      data = request(:get, url, opts)

      if @auto_paginate && data.is_a?(Array)
        while @last_response.rels[:next] && rate_limit.remaining > 0
          @last_response = @last_response.rels[:nest].get
          data.concat(@last_response.data) if @last_response.data.is_a?(Array)
        end
      end

      data
    end

    # Hyprtmedia agent for the API
    #
    # @return [Sawyer::Agent]
    def agent
      @agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
        http.headers[:accept] = default_media_type
        http.headers[:user_agent] = user_agent
        http.authorization 'token', @access_token
      end
    end

    private

    def request(method, path, data, options = {})
      if data.is_a?(Hash)
        options[:query] = data.delete(:query) || {}
        options[:headers] = data.delete(:headers) || {}
        if accept = data.delete(:accept)
          options[:headers][:accept] = accept
        end
      end
      if application_authenticated?
        options[:query].merge! application_authentication
      end

      @last_response = response = agent.call(method, URI.encode(path.to_s), data, options)
      response.data
    end

    # Executes the request, checking if it was successful
    #
    # @return [Boolean] True on success, false otherwise
    def boolean_from_response(method, path, options = {})
      request(method, path, options)
      @last_response.status == 204
    rescue Doufuru::NotFound
      false
    end

    def sawyer_options
      opts = { link_parser: Sawyer::LinkParsers::Simple.new }
      conn_opts = @connection_options
      conn_opts[:builder] = @middleware if @middleware
      conn_opts[:proxy] = @proxy if @proxy
      opts[:faraday] = Faraday.new(conn_opts)

      opts
    end

    def parse_query_and_convenience_headers(options)
      headers = options.fetch(:headers, {})
      query = options.delete(:query)
      opts = { query: options }
      opts[:query].merge!(query) if query && query.is_a?(Hash)
      opts[:headers] = headers unless headers.empty?

      opts
    end

  end

end
