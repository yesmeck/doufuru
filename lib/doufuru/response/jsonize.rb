# encoding: utf-8

require "faraday"
require "doufuru/jsonable"

module Doufuru
  class Response::Jsonize < Response
    include Doufuru::Jsonable

    dependency "multi_json"

    define_parser do |body|
      Doufuru::Jsonable.decode body
    end

    def parse(body)
      case body
      when ""
        nil
      when "true"
        true
      when "false"
        false
      else
        self.class.parser.call body
      end
    end
  end
end
