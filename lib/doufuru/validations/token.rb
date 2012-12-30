# encoding: utf-8

module Doufuru
  module Validations
    module Token

      TOKEN_REQUIRED = [
      ]

      TOKEN_REQUIRED_REGEXP = [
      ]

      # Ensures that required authentication token is present before
      # request is sent.
      #
      def validates_token_for(method, path)
        return true unless TOKEN_REQUIRED.grep("#{method} #{path}").empty?

        token_required = false
        TOKEN_REQUIRED_REGEXP.each do |regex|
          if "#{method} #{path}" =~ regex
            token_required = true
          end
        end
        return token_required
      end

    end
  end
end
