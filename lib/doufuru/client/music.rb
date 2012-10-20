# encoding: utf-8

module Doufuru
  class Client
    module Music
      def music(id, params = {})
        get("/music/#{id}", params)
      end

      def music_tags(id, params = {})
        get("/music/#{id}/tags", params).tags
      end

      def create_music_review(params = {})
        post("/music/reviews", params)
      end

      def update_music_review(review_id, params = {})
        put("/music/review/#{review_id}", params)
      end

      def delete_music_review(review_id, params = {})
        response = delete("/music/review/#{review_id}", params, true)
        if response == "\"OK\""
          response = "ok"
        end
        response
      end

      def music_user_tags(uid, params = {})
        get("/music/user_tags/#{uid}", params).tags
      end
    end
  end
end
