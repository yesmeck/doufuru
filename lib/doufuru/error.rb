module Doufuru

  #Custom error class for rescuing from all Douban errors
  class Error < StandardError

    def initialize(response = nil)
      @response = response
      super(build_error_message)
    end

    # Docimentation URL returned by the API for some errors
    #
    # @return [String]
    def documentation_url
      data[:documentation_url] if data
    end

    def errors
      if data && data.is_a?(Hash)
        data[:errors] || []
      else
        []
      end
    end

    private

    def data
      @data ||= if (body = @response[:body]) && !body.empty?
                  if body.is_a?(String) &&
                    @response[:response_headers] &&
                    @response[:response_headers][:content_type] =~ /json/

                    Sawyer::Agent.serializer.decode(body)
                  else
                    body
                  end
                else
                  nil
                end
    end

    def response_message
      case data
      when Hash
        data[:message]
      when String
        data
      end
    end

    def response_error
      "Error: #{data[:error]}" if data.is_a?(Hash) && data[:error]
    end

    def response_error_summary
      return nil unless data.is_a?(Hash) && !Array(data[:errors]).empty?

      summary = "\n Error summary:\n"
      summary << data[:errors].map { |error| error.map { |k, v| "  #{k}: #{v}" } }.join("\n")
    end

    def build_error_message
      return nil if @response.nil?

      message = "#{@response[:method].to_s.upcase} "
      message << "#{@response[:url].to_s}: "
      message << "#{@response[:status]} - "
      message << "#{response_message}" unless response_message.nil?
      message << "#{response_error}" unless response_error.nil?
      message << "#{response_error_summary}" unless response_error_summary.nil?
      message << " // See: #{documentation_url}" unless documentation_url.nil?
      message
    end

    class << self

      # Returns thr appropriate Doufuru::Error subclass based
      # on ststus and response message
      #
      # @param [Hash] response HTTP response
      # @return [Doufuru::Error]
      def from_response(response)
        status = response[:status].to_i
        body = response[:body].to_s
        headers = response[:response_headers]

        if klass = case status
                   when 404 then Doufuru::NotFound
                   end

          klass.new(response)
        end
      end

    end

  end

  class NotFound < Error; end

end
