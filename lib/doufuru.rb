# encoding: utf-8

require "pry" if ENV["DOUFURU_DEV"]
require "pry-nav" if ENV["DOUFURU_DEV"]
require "parts"
require "doufuru/core_ext/object"
require "doufuru/parts/file_part"
require "doufuru/configuration"
require "doufuru/autoloader"

module Doufuru
  extend Configuration
  extend Autoloader

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

  autoload_all "doufuru",
    :API        => "api",
    :Client     => "client",
    :Book       => "book"

end
