# encoding: utf-8

module Doufuru
  class Client
    module Movie
      def movie(id, params = {})
        get("movie/#{id}", params)
      end
    end
  end
end
