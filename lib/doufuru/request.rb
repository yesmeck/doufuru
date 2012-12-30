# encoding: utf-8

module Doufuru
  module Request

    METHODS = [:get, :post, :put, :delete, :patch]
    METHODS_WITH_BODIES = [ :post, :put, :patch ]

    def get_request(path, params = {}, options = {})
      request(:get, path, params, options)
    end

    def post(path, params = {}, raw = false)
      request(:post, path, params, raw)
    end

    def put(path, params = {}, raw = false)
      request(:put, path, params, raw)
    end

    def delete(path, params = {}, raw = false)
      request(:delete, path, params, raw)
    end

    def request(method, path, params, options)

      puts "EXECUTED: #{method} - #{path} with #{params} and #{options}" if ENV["DOUFURU_DEBUG"]

      conn = connection(options)
      path = (conn.path_prefix + path).gsub(/\/\//,"/") if conn.path_prefix != "/"

      response = conn.send(method) do |request|
        case method.to_sym
        when *(METHODS - METHODS_WITH_BODIES)
          request.body = params.delete("data") if params.has_key?("data")
          request.url(path, params)
        when *METHODS_WITH_BODIES
          request.path = path
          request.body = extract_data_from_params(params) unless params.empty?
        end
      end

      response.body
    end

    private

    def extract_data_from_params(params) # :nodoc:
      return params["data"] if params.has_key?("data") and !params["data"].nil?
      return params
    end

    def _extract_mime_type(params, options) # :nodoc:
      options["resource"]  = params["resource"] ? params.delete("resource") : ""
      options["mime_type"] = params["resource"] ? params.delete("mime_type") : ""
    end

  end
end
