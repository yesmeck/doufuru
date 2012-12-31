# encoding: utf-8

require "doufuru/api"
require "doufuru/api_factory"

module Doufuru
  class Client < API

    def book(*args)
      args = [{}] if args.empty?
      if !args.empty? && !args[0].is_a?(Hash)
        return Doufuru::Books.new(args[0])
      else
        return @book ||= ApiFactory.new("Books", args[0])
      end
    end

  end
end
