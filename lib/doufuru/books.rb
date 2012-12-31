# encoding: utf-8

module Doufuru
  class Books < API

    def initialize(options = {})
      super(options)
    end

    def tags(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}/tags").tags
    end

    def get(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}", params)
    end
    alias :find :get

    def get_by_isbn(isbn, params = {})
      set :isbn => isbn
      assert_presence_of isbn
      normalize! params

      get_request("/book/isbn/#{isbn}", params)
    end
    alias :find_by_isbn :get_by_isbn

    def search(params = {})
      normalize! params
      assert_presence_of params["q"] if params["tag"].nil?
      assert_presence_of params["tag"] if params["q"].nil?

      get_request("/book/search", params).books
    end
  end
end
