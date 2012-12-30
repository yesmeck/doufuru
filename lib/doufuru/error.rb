# encoding: utf-8

require "doufuru/descendants"

module Doufuru
  module Error
    class DoufuruError < StandardError
      extend Descendants

      attr_reader :response_message, :response_headers

      # Initialize a new Github error object.
      #
      def initialize(message=$!)
        if message.respond_to?(:backtrace)
          super(message.message)
          @response_message = message
        else
          super(message.to_s)
        end
      end

      def backtrace
        @response_message ? @response_message.backtrace : super
      end

    end
  end
end

Dir["#{File.dirname(__FILE__)}/error/*.rb"].each { |f| require f }
