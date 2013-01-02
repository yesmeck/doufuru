# encoding: utf-8

require "spec_helper"

describe Doufuru::Client do

  let(:doufuru) { Doufuru.new }

  describe "#book" do

    context "with book id passed" do

      let(:id) { 1084336 }
      let(:request_path) { "/book/#{id}" }

      before do
        stub_get(request_path).to_return(:body => fixture("book/book.json"))
      end

      it "should get the book " do
        book = doufuru.book(id)
        book.title.should == "小王子"
      end
    end

    it "should return Doufuru::Book instance" do
      doufuru.book.should be_a Doufuru::Book
    end

  end

end
