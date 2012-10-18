# encoding: utf-8

module Doufuru
  class Client
    module User
      def user(user = '~me', params = {})
        get("/user/#{user}", params)
      end

      def search_users(params = {})
        get("/user", params)['users']
      end

      def user_following(uid, params = {})
        get("/shuo/users/#{uid}/following", params)
      end
    end
  end
end
