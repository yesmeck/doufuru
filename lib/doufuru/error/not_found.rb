# encoding: utf-8

require "doufuru/error/service_error"

module Doufuru
  # Raised when Github returns the HTTP status code 404
  module Error
    class NotFound < ServiceError
      http_status_code 404

      def initialize(env)
        super(env)
      end
    end
  end
end
