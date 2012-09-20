# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @client = Doufuru::Client.new
  end

  describe ".book" do
    context "with a id passed" do
      it "should return the book" do
        stub_get("/book/1084336").to_return(:body => fixture("book.json"))
        book = @client.book(1084336)
        book.title.should == "小王子"
      end
    end
  end
end
