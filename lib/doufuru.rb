# encoding: utf-8

require "parts"
require "doufuru/core_ext/object"
require "doufuru/parts/file_part"
require "doufuru/version"
require "doufuru/configuration"
require "doufuru/client"

module Doufuru
  extend Configuration

  class << self
    def new(options = {})
      Doufuru::Client.new(options)
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
