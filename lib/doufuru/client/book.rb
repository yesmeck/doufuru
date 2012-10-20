# encoding: utf-8

module Doufuru
  class Client
    module Book
      def book(id, params = {})
        get("/book/#{id}")
      end

      def book_by_isbn(isbn, params = {})
        get("/book/isbn/#{isbn}")
      end

      def search_books(params = {})
        get("/book/search", params).books
      end

      def book_tags(id, params = {})
        get("/book/#{id}/tags").tags
      end

      def create_book_review(params = {})
        post("/book/reviews", params)
      end

      def update_book_review(review_id, params = {})
        put("/book/review/#{review_id}", params)
      end

      def delete_book_review(review_id, params = {})
        response = delete("/book/review/#{review_id}", params, true)
        if response == "\"OK\""
          response = "ok"
        end
        response
      end

      def book_user_tags(uid, params = {})
        get("/book/user/#{uid}/tags", params).tags
      end

      def book_user_collections(uid, params = {})
        get("/book/user/#{uid}/collections", params).collections
      end

      def book_collection(id, params = {})
        get("/book/#{id}/collection", params)
      end

      def create_book_collection(id, params = {})
        post("/book/#{id}/collection", params)
      end

      def update_book_collection(id, params = {})
        put("/book/#{id}/collection", params)
      end
    end
  end
end
