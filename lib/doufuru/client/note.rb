# encoding: utf-8

module Doufuru
  class Client
    module Note
      def create_note(params = {})
        post("/notes", params)
      end

      def update_note(id, params = {})
        put("/note/#{id}", params)
      end

      def delete_note(id, params = {})
        response = delete("/note/#{id}", params, true)
        if response == '{}'
          response = 'ok'
        end
        response
      end

      def note(id, params = {})
        get("/note/#{id}", params)
      end
    end
  end
end
