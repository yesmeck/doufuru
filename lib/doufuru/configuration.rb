#encoding: utf-8

module Doufuru
  module Configuration

    VALID_OPTIONS_KEYS = [
      :adapter,
      :endpoint,
      :user_agent,
      :oauth_token,
      :user
    ].freeze

    DEFAULT_ADAPTER = :net_http

    DEFAULT_ENDPOINT = "https://api.douban.com/v2".freeze

    DEFAULT_USER_AGENT = "Doufuru #{Doufuru::VERSION::STRING}".freeze

    DEFAULT_USER = nil

    DEFAULT_OAUTH_TOKEN = nil

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.set_defaults
    end

    def configure
      yield self
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    def set_defaults
      self.adapter = DEFAULT_ADAPTER
      self.endpoint = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self.oauth_token = DEFAULT_OAUTH_TOKEN
      self.user = DEFAULT_USER
    end
  end
end
