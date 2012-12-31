# encoding: utf-8

module Doufuru
  class Books < API

    def get(id, params = {})
      set :id => id
      assert_presence_of id

      get_request("/book/#{id}", params)
    end
    alias :find :get

    def get_by_isbn(isbn, params = {})
      set :isbn => isbn
      assert_presence_of isbn

      get_request("/book/isbn/#{isbn}", params)
    end
    alias :find_by_isbn :get_by_isbn

  end
end
