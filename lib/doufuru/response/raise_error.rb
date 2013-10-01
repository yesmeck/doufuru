require 'faraday'
require 'doufuru/error'

module Doufuru

  # Faraday response middleware
  module Response

    class RaiseError < Faraday::Response::Middleware
      private

      def on_complete(response)
        if error = Doufuru::Error.from_response(response)
          raise error
        end
      end
    end

  end

end
