# encoding: utf-8

module Doufuru
  class Books::Collection < API

    def get(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}/collection")
    end

  end
end
