# encoding: utf-8

require "spec_helper"

describe Doufuru::Books, "#search" do

  let(:keyword) { "小王子" }
  let(:tag) { "小王子" }
  let(:request_path) { "/book/search" }

  before do
    stub_get(request_path).with(:query => query).to_return(:body => body)
  end

  context "with keyword passed" do
    let(:query) { {:q => keyword} }
    let(:body) { fixture("books/books.json") }

    it "should search the books" do
      subject.search :q => keyword
      a_get(request_path).with(:query => {:q => keyword}).should have_been_made
    end

    it "should get the books" do
      books = subject.search :q => keyword
      books.first.title.should == "小王子"
    end
  end

  context "with tag passed" do
    let(:query) { {:tag => tag} }
    let(:body) { fixture("books/books.json") }

    it "should search the books" do
      subject.search :tag => tag
      a_get(request_path).with(:query => {:tag => tag}).should have_been_made
    end

    it "should get the books" do
      books = subject.search :tag => tag
      books.first.title.should == "小王子"
    end
  end

end
