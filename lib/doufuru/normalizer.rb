# encoding: utf-8

module Doufuru
  module Normalizer
    def normalize!(params)
      case params
      when Hash
        params.keys.each do |k|
          params[k.to_s] = params.delete(k)
          normalize!(params[k.to_s])
        end
      when Array
        params.map! do |i|
          normalize!(i)
        end
      else
        params.to_s
      end
      return params
    end
  end
end
