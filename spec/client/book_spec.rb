# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @client = Doufuru::Client.new
    @book_title = "小王子"
  end

  describe ".book" do
    context "with a id passed" do
      it "should return the book" do
        id = 1084336
        stub_get("/book/#{id}").to_return(:body => fixture("book.json"))
        book = @client.book(id)
        book.title.should == @book_title
      end
    end
  end

  describe ".book_by_isbn" do
    context "with a isbn id passed" do
      it "should return the book" do
        isbn = 9787020042494
        stub_get("/book/isbn/#{isbn}").to_return(:body => fixture("book.json"))
        book = @client.book_by_isbn(isbn)
        book.title.should == @book_title
      end
    end
  end

  describe ".search_books" do
    context "with a keyword passed" do
      it "should return matching books" do
        params = {:q => @book_title, :start => 0, :count => 10}
        stub_get("/book/search").
          with(:query => params).
          to_return(:body => fixture("books.json"))
        books = @client.search_books(params)
        books.first.title.should == @book_title
      end
    end
    context "with a tag passed" do
      it "should return matching books" do
        params = {:tag => @book_title, :start => 0, :count => 10}
        stub_get("/book/search").
          with(:query => params).
          to_return(:body => fixture("books.json"))
        books = @client.search_books(params)
        books.first.title.should == @book_title
      end
    end
  end
end
