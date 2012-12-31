# encoding: utf-8

module Doufuru
  class Books::User < API

    def tags(username, params = {})
      set :username => username
      assert_presence_of username
      normalize! params

      get_request("/book/user/#{username}/tags").tags
    end

  end
end
