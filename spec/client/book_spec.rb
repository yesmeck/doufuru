# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @client = Doufuru::Client.new
  end

  describe ".book" do
    context "with a id passed" do
      it "should return the book" do
        id = 1084336
        stub_get("/book/#{id}").to_return(:body => fixture("book.json"))
        book = @client.book(id)
        book.title.should == "小王子"
      end
    end
  end

  describe ".book_by_isbn" do
    context "with a isbn id passed" do
      it "should return the book" do
        isbn = 9787020042494
        stub_get("/book/isbn/#{isbn}").to_return(:body => fixture("book.json"))
        book = @client.book_by_isbn(isbn)
        book.title.should == "小王子"
      end
    end
  end
end
