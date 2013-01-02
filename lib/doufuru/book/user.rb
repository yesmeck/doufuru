# encoding: utf-8

module Doufuru
  class Book::User < API

    def tags(username, params = {})
      set :username => username
      assert_presence_of username
      normalize! params

      get_request("/book/user/#{username}/tags").tags
    end

    def collections(username, params = {})
      set :username => username
      assert_presence_of username
      normalize! params

      get_request("/book/user/#{username}/collections").collections
    end

    def annotations(username, params = {})
      set :username => username
      assert_presence_of username

      get_request("/book/user/#{username}/annotations").annotations
    end

  end
end
