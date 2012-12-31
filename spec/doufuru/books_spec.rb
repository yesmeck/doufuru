# encoding: utf-8

require "spec_helper"

describe Doufuru::Books do
  it_should_behave_like "api interface"

  its(:user) { should be_a Doufuru::Books::User }

  let(:id) { 1084336 }
  let(:request_path) { "/book/#{id}" }

  context "initialize with a id" do

    before do
      stub_get(request_path).to_return(:body => body)
    end

    let(:body) { fixture("books/book.json") }

    it "should request the book" do
      Doufuru::Books.new(id)
      a_get(request_path).should have_been_made
    end

    it "should get the book " do
      book = Doufuru::Books.new(id)
      book.title.should == "小王子"
    end

  end

  context "initialize witout id" do

    it "should return a instance of Doufuru::Books" do
      book = Doufuru::Books.new({})
      book.should be_a Doufuru::Books
    end

  end

end
