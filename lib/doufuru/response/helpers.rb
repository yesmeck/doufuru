# encoding: utf-8

require "faraday"
require "doufuru/result"

module Doufuru
  class Response::Helpers < Response

    def on_complete(env)
      env[:body].class.class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        include Doufuru::Result

        def env
          @env
        end
      RUBY_EVAL
    end

  end
end
