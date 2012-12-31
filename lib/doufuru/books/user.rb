# encoding: utf-8

module Doufuru
  class Books::User < API

    def tags(user, params = {})
      set :user => user
      assert_presence_of user
      normalize! params

      get_request("/book/user/#{user}/tags").tags
    end

  end
end
