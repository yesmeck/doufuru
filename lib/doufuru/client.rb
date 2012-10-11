# encoding: utf-8

require "doufuru/oauth"
require "doufuru/connection"
require "doufuru/request"

require "doufuru/client/user"
require "doufuru/client/book"
require "doufuru/client/shuo"
require "doufuru/client/movie"
require "doufuru/client/music"
require "doufuru/client/event"
require "doufuru/client/discussion"

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
    include Doufuru::Client::Shuo
    include Doufuru::Client::Movie
    include Doufuru::Client::Music
    include Doufuru::Client::Event
    include Doufuru::Client::Discussion
  end
end
