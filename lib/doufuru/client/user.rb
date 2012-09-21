# encoding: utf-8

module Doufuru
  class Client
    module User
      def user(user = '~me')
        get("user/#{user}")
      end

      def search_users(params = {})
        get("user", params)['users']
      end
    end
  end
end
