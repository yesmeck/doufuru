# encoding: utf-8

module Doufuru
  module ParameterFilter
    def filter!(keys, params, options={:recursive => true})
      case params
      when Hash
        params.keys.each do |k, v|
          unless (keys.include?(k) or Doufuru::Validations::VALID_API_KEYS.include?(k))
            params.delete(k)
          else
            filter!(keys, params[k]) if options[:recursive]
          end
        end
      when Array
        params.map! do |el|
          filter!(keys, el) if options[:recursive]
        end
      else
        params
      end
      return params
    end
  end
end
