# encoding: utf-8

require "helper"

module Doufuru
  class Client
    module Music
      def music(id, params = {})
        get("/music/#{id}", params)
      end
    end
  end
end
