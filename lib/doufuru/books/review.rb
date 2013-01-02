# encoding: utf-8

module Doufuru
  class Books::Review < API

    def get(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/review/#{id}", params)
    end

  end
end
