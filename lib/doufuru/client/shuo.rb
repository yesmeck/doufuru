# encoding: utf-8

module Doufuru
  class Client
    module Shuo
      def create_shuo(params = {})
        post('/shuo/statuses/', params)
      end
    end
  end
end
