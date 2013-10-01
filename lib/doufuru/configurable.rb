module Doufuru

  # Configution options for {Client}, defaulting to values in {Default}
  module Configurable
    # @!attribute access_token
    #   @return [Strung] OAuth2 access tolen fot authentication
    # @!attribute api_endpoint
    #   @return [Strung] Base URL for API requests. default: https://api.douban.com/v2
    # @!attribute auto_paginate
    #   @return [Boolean] Auto fetch next page of results until rate limit reached
    # @!attribute client_id
    #   @return [String] Configure OAuth app key
    # @!attribute [w] client_secret
    #   @return [String] Configure OAuth app secret
    # @!attribute default_media_type
    #   @return [String] Configure preferred media type.
    # @!attribute connection_options
    #   @return [Hash] Configure connection options for Farafay
    # @!attribute login
    #   @return [String] Douban username
    # @!attribute middleware
    #   @return [Faraday::Builder] Configure middleware for Farafay
    # @!attribute per_page
    #   @return [Fixnum] Configure page size for paginated results. default: 50
    # @!attribute proxy
    #   @return [String] URI for proxy server
    # @!attribute user_agent
    #   @return [String] Configure User-Agent header for requests.
    # @!attribute web_endpoint
    #   @return [String] Base URL for wen URLs. default: http://www.douban.com
    attr_accessor :access_token, :api_endpoint, :auto_paginate, :client_id,
      :default_media_type, :connection_options,  :login, :middleware, :per_page,
      :proxy, :user_agent, :web_endpoint
    attr_writer :client_secret

    class << self
      # List of configurable keys for {Doufuru::Client}
      #
      # @return [Array] of options keys
      def keys
        @keys ||= [
          :access_token,
          :api_endpoint,
          :auto_paginate,
          :client_id,
          :client_secret,
          :connection_options,
          :default_media_type,
          :login,
          :middleware,
          :per_page,
          :proxy,
          :user_agent,
          :web_endpoint
        ]
      end
    end

    # Set configation options using a block
    def configure
      yield self
    end

    # Set configration options to default values
    def reset!
      Doufuru::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Doufuru::Default.options[key])
      end
    end
    alias setup reset!

    def api_endpoint
      File.join(@api_endpoint, '')
    end

    def web_endpoint
      File.join(@web_endpoint, '')
    end

    def loigin
      @login ||= begin
                   user.login if token_authenticated?
                 end
    end

    private

    def options
      Hash[Doufuru::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    def fetch_client_id_and_secret(overrides = {})
      opts = options.merge(overrides)
      opts.values_at :client_id, :client_secret
    end
  end

end
