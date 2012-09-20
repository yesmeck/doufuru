# encoding: utf-8

module Doufuru
  module Oauth
    def oauthed?
      !access_token.nil?
    end
  end
end
