# encoding: utf-8

module Doufuru
  class Client
    module Movie
      def movie(id, params = {})
        get("movie/#{id}", params)
      end

      def movie_by_imdb(imdb, params = {})
        get("movie/imdb/#{imdb}", params)
      end

      def search_movies(params = {})
        get("movie/search", params).movies
      end

      def movie_tags(id, params = {})
        get("movie/#{id}/tags", params).tags
      end
    end
  end
end
