# encoding: utf-8

module Doufuru
  class Client
    module Book
      def book(id)
        get("book/#{id}")
      end
    end
  end
end
