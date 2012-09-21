# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @book_id = 1084336
    @book_title = "小王子"
    @review_title = "测试"
    @review_content = "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"
    @rating = 5
    @client = Doufuru::Client.new(:access_token => @access_token)
  end

  describe ".book" do
    context "with a id passed" do
      it "should return the book" do
        stub_get("/book/#{@book_id}").to_return(:body => fixture("book.json"))
        book = @client.book(@book_id)
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

  describe ".book_tags" do
    context "with a book id passed" do
      it "should return a tag list of the book" do
        stub_get("/book/#{@book_id}/tags").to_return(:body => fixture("book_tags.json"))
        book_tags = @client.book_tags(@book_id)
        book_tags.first.title = @book_title
      end
    end
  end

  describe ".create_book_review" do
    it "it should create a book review" do
      title = "hello"
      content = "world"
      stub_post("/book/reviews").with(
        :content => {
          :book => @book_id,
          :title => @review_title,
          :content => @review_content,
          :rating => @rating
        },
        :headers => {
          "Authorization" => "Bearer #{@access_token}"
        }
      ).to_return(:body => fixture("book_review_create.json"))
      review = @client.create_book_review({
        :book => @book_id,
        :title => @review_title,
        :content => @review_content,
        :rating => @rating
      })
      review.book.title.should == @book_title
      review.title.should == @review_title
      review.content.should == @review_content
      review.rating.value = @rating
    end
  end
end
