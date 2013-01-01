# encoding: utf-8

module Doufuru
  class Books::Collection < API

    def get(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}/collection")
    end

    def create(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      post_request("/book/#{id}/collection")
    end

    def update(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      put_request("/book/#{id}/collection")
    end

  end
end
