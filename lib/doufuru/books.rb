# encoding: utf-8

module Doufuru
  class Books < API
    def get(id, params = {})
      set :id => id
      assert_presence_of id

      get_request("/book/#{id}", params)
    end
    alias :find :get
  end
end
