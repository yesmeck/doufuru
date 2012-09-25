#encoding: utf-8

module Doufuru
  module Configuration
    VALID_OPTIONS_KEYS = [
      :api_version,
      :api_url,
      :access_token
    ]

    API_VERSION = 2
    API_URL = "https://api.douban.com/v2/"

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) {|o, k| o.merge!(k => send(k))}
    end

    def reset
      self.api_version = API_VERSION
      self.api_url = API_URL
      self.access_token = nil
    end
  end
end
