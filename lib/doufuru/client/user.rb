# encoding: utf-8

module Doufuru
  class Client
    module User
      def user(user)
        get("user/#{user}")
      end
    end
  end
end
