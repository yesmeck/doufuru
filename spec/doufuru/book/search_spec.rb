# encoding: utf-8

require "spec_helper"

describe Doufuru::Book, "#search" do

  let(:keyword) { "小王子" }
  let(:tag) { "小王子" }
  let(:request_path) { "/book/search" }

  before do
    stub_get(request_path).with(:query => query).to_return(:body => body)
  end

  context "with keyword passed" do
    let(:query) { {:q => keyword} }
    let(:body) { fixture("book/books.json") }

    it "should search the book" do
      subject.search :q => keyword
      a_get(request_path).with(:query => {:q => keyword}).should have_been_made
    end

    it "should get the book" do
      book = subject.search :q => keyword
      book.first.title.should == "小王子"
    end
  end

  context "with tag passed" do
    let(:query) { {:tag => tag} }
    let(:body) { fixture("book/books.json") }

    it "should search the book" do
      subject.search :tag => tag
      a_get(request_path).with(:query => {:tag => tag}).should have_been_made
    end

    it "should get the book" do
      book = subject.search :tag => tag
      book.first.title.should == "小王子"
    end
  end

end
