# encoding: utf-8

require "doufuru/oauth"
require "doufuru/connection"
require "doufuru/request"

require "doufuru/client/user"
require "doufuru/client/book"
require "doufuru/client/movie"

module Doufuru
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Doufuru.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Doufuru::Oauth
    include Doufuru::Connection
    include Doufuru::Request

    include Doufuru::Client::User
    include Doufuru::Client::Book
    include Doufuru::Client::Movie
  end
end
