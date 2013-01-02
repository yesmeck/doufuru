# encoding: utf-8

module Doufuru
  class Books::Review < API

    def get(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/review/#{id}", params)
    end

    def create(params)
      normalize! params
      assert_presence_of params["book"]
      assert_presence_of params["title"]
      assert_presence_of params["content"]

      post_request("/book/reviews", params)
    end

  end
end