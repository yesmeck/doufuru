# encoding: utf-8

module Doufuru
  class Books::Annotation < API

    def list(book_id, params = {})
      set :id => book_id
      assert_presence_of book_id
      normalize! params

      get_request("/book/#{book_id}/annotations").annotations
    end

    def get(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/annotation/#{id}")
    end

    def create(book_id, params = {})
      set :book_id => book_id
      assert_presence_of book_id
      normalize! params

      post_request("/book/#{book_id}/annotations", params)
    end

  end
end
