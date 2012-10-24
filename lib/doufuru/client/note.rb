# encoding: utf-8

module Doufuru
  class Client
    module Note
      def create_note(params = {})
        post("/notes", params)
      end
    end
  end
end
