# encoding: utf-8

require "spec_helper"

describe Doufuru::Client do
  include_context "initialize client"

  before do
    @book_id = "1084336"
    @book_title = "小王子"
    @review_title = "测试"
    @review_content = "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"
    @rating = "5"
    @review_id = 5591773
    @uid = "coolzi"
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
        book_tags.first.title.should == @book_title
      end
    end
  end

  describe ".create_book_review" do
    it "should create a book review" do
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
      review.rating.value.should == @rating
    end
  end

  describe ".update_book_review" do
    context "with a review id passed" do
      it "should update the book review" do
        review_content = "因为，绳命，是剁么的回晃；绳命，是入刺的井猜。壤窝们，巩痛嘱咐碰优。田下冯广宰饿妹，饿妹冯广宰呲处。壤窝们，嘱咐这缩优类缩优。开心的一小，火大的一小，壤绳命，梗楤容，壤绳命，梗秤巩，壤绳命，梗回晃。"

        stub_put("/book/review/#{@review_id}").with(
          :content => {
            :title => @review_title,
            :content => @review_content,
            :rating => @rating
          },
          :headers => {
            "Authorization" => "Bearer #{@access_token}"
          }
        ).to_return(:body => fixture("book_review_update.json"))

        review = @client.update_book_review(@review_id, {
          :title => @review_title,
          :content => @review_content,
          :rating => @rating
        })
        review.book.title.should == @book_title
        review.title.should == @review_title
        review.content.should == review_content
        review.rating.value.should == @rating
      end
    end
  end

  describe ".delete_book_review" do
    context "with a review id passed" do
      it "should delete the review" do
        stub_delete("/book/review/#{@review_id}").with(:headers => {
          "Authorization" => "Bearer #{@access_token}"
        }).to_return(:body => "\"OK\"")

        result = @client.delete_book_review(@review_id)
        result.should == "ok"
      end
    end
  end

  describe ".book_user_tags" do
    context "with a user id passed" do
      it "should return the user's all book's tags." do
        stub_get("/book/user/#{@uid}/tags").
          to_return(:body => fixture("book_user_tags.json"))

        tags = @client.book_user_tags(@uid)
        tags.first.title.should eq "余华"
      end
    end
  end

  describe ".book_user_collections" do
    context "with a user id passed" do
      it "should return the user's book collections." do
        stub_get("/book/user/#{@uid}/collections").
          to_return(:body => fixture("book_user_collections.json"))

        books = @client.book_user_collections(@uid)
        books.first.id.should eq 592321300
      end
    end
  end

  describe ".book_collection" do
    context "with a book id passed" do
      it "should return the oauthed user's collection info of the book." do
        stub_get("/book/#{@book_id}/collection").
          with(:headers => {
            "Authorization" => "Bearer #{@access_token}"
          }).
          to_return(:body => fixture("book_collection.json"))

        book = @client.book_collection(@book_id)
        book.book_id.should eq @book_id
        book.status.should eq "read"
      end
    end
  end

  describe ".create_book_collection" do
    context "with a book id passed" do
      it "should add the book to the oauthed user's collection list." do
        params = { :status => 'read' }
        stub_post("/book/#{@book_id}/collection").
          with(
            :content => params,
            :headers => {
              "Authorization" => "Bearer #{@access_token}"
            }
          ).
          to_return(:body => fixture("book_collection.json"))

        book = @client.create_book_collection(@book_id, params)
        book.book_id.should eq @book_id
        book.status.should eq "read"
      end
    end
  end

  describe ".update_book_collection" do
    context "with a book id passed" do
      it "should update the book's collection status." do
        params = { :status => 'read' }
        stub_put("/book/#{@book_id}/collection").
          with(
            :content => params,
            :headers => {
              "Authorization" => "Bearer #{@access_token}"
            }
          ).
          to_return(:body => fixture("book_collection.json"))

        book = @client.update_book_collection(@book_id, params)
        book.book_id.should eq @book_id
        book.status.should eq "read"
      end
    end
  end

  describe ".delete_book_collection" do
    context "with a book id passed" do
      it "should delete the book's collection." do
        stub_delete("/book/#{@book_id}/collection").
          with(
            :headers => {
              "Authorization" => "Bearer #{@access_token}"
            }
          ).
          to_return(:body => '')

        response = @client.delete_book_collection(@book_id)
        response.should eq "ok"
      end
    end
  end
end
