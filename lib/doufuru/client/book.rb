# encoding: utf-8

module Doufuru
  class Client
    module Book
      def book(id)
        get("book/#{id}")
      end

      def book_by_isbn(isbn)
        get("book/isbn/#{isbn}")
      end
    end
  end
end
