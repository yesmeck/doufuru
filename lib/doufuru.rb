# encoding: utf-8

require "pry" if ENV["DOUFURU_DEV"]
require "pry-nav" if ENV["DOUFURU_DEV"]
require "parts"
require "doufuru/core_ext/object"
require "doufuru/parts/file_part"
require "doufuru/version"
require "doufuru/configuration"
require "doufuru/api"
require "doufuru/client"
require "doufuru/books"
require "doufuru/books/user"
require "doufuru/books/collection"
require "doufuru/books/annotation"
require "doufuru/books/review"

module Doufuru
  extend Configuration

  class << self

    attr_accessor :api_client

    def new(options = {}, &block)
      Doufuru::Client.new(options, &block)
    end

    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def repspond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
