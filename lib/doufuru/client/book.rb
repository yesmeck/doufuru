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

      def search_books(params)
        get("book/search", params).books
      end

      def book_tags(id)
        get("book/#{id}/tags").tags
      end

      def create_book_review(params)
        post("book/reviews", params)
      end
    end
  end
end
