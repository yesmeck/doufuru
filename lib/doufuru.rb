# encoding: utf-8

# MultiParts 计算的 Content-Lenght 跟豆瓣服务器的计算结果不一至，导致请求失败，
# 所以没办法只能在这里打个 monkey patch。
require 'parts'

class Object
  def require(file)
    if file != "parts"
      super
    end
  end
end

module Parts
  class FilePart
    alias origin_initialize initialize
    def initialize(boundary, name, io)
      origin_initialize(boundary, name, io)
      @length -= @foot.length
    end
  end
end

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
