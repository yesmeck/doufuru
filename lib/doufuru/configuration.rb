#encoding: utf-8

module Doufuru
  module Configuration
    VALID_OPTIONS_KEYS = [
      :api_version,
      :api_url
    ]

    API_VERSION = 2
    API_URL = "https://api.douban.com/v2/"

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def reset
      self.api_version = API_VERSION
      self.api_url = API_URL
    end
  end
end
