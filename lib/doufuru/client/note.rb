# encoding: utf-8

module Doufuru
  class Client
    module Note
      def create_note(params = {})
        post("/notes", params)
      end

      def delete_note(id, params = {})
        response = delete("/note/#{id}", params, true)
        if response == '{}'
          response = 'ok'
        end
        response
      end
    end
  end
end
