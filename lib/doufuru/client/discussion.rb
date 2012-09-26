# encoding: utf-8

module Doufuru
  class Client
    module Discussion
      def discussion(id, params = {})
        get("/discussion/#{id}", params)
      end

      def update_discussion(id, params = {})
        put("/discussion/#{id}", params)
      end

      def delete_discussion(id, params = {})
        response = delete("/discussion/#{id}", params, true)

        if response == '{}'
          response = 'ok'
        end
        response
      end

      def create_discussion(target_id, params = {})
        post("/target/#{target_id}/discussions", params)
      end
    end
  end
end
