# encoding: utf-8

module Doufuru
  class Client
    module Movie
      def movie(id, params = {})
        get("/movie/#{id}", params)
      end

      def movie_by_imdb(imdb, params = {})
        get("/movie/imdb/#{imdb}", params)
      end

      def search_movies(params = {})
        get("/movie/search", params).movies
      end

      def movie_tags(id, params = {})
        get("/movie/#{id}/tags", params).tags
      end

      def create_movie_review(params = {})
        post("/movie/reviews", params)
      end

      def update_movie_review(review_id, params = {})
        put("/movie/review/#{review_id}", params)
      end

      def delete_movie_review(review_id, params = {})
        response = delete("/movie/review/#{review_id}", params, true)
        if response == "\"OK\""
          response = "ok"
        end
        response
      end

      # 这里的 uid 只能是数字 uid
      def movie_user_tags(uid, params = {})
        get("/movie/user_tags/#{uid}", params).tags
      end
    end
  end
end
