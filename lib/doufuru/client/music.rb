# encoding: utf-8

require "helper"

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
    end
  end
end
