# encoding: utf-8

module Doufuru
  class Client
    module Event
      def event(id, params = {})
        get("/event/#{id}", params)
      end
    end
  end
end
