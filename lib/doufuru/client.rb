# encoding: utf-8

require "doufuru/connection"
require "doufuru/request"

require "doufuru/client/user"

module Doufuru
  class Client
    include Doufuru::Connection
    include Doufuru::Request

    include Doufuru::Client::User
  end
end
