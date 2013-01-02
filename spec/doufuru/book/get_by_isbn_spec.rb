# encoding: utf-8

require "spec_helper"

describe Doufuru::Book, "#get_by_isbn" do
  let(:isbn) { "702004249X" }
  let(:request_path) { "/book/isbn/#{isbn}" }

  before do
    stub_get(request_path).to_return(
      :body => body,
      :status => status,
      :headers => { :content_type => "application/json; charset=utf-8" }
    )
  end

  context "book found" do
    let(:body) { fixture("book/book.json") }
    let(:status) { 200 }

    it { subject.should respond_to(:find_by_isbn) }

    it "should find book" do
      subject.get_by_isbn isbn
      a_get(request_path).should have_been_made
    end

    it "should return book mash" do
      book = subject.get_by_isbn isbn
      book.should be_a Hashie::Mash
    end

    it "should get book information" do
      book = subject.get_by_isbn isbn
      book.title.should == "小王子"
    end
  end

  it_should_behave_like "request failure" do
    let(:requestable) { subject.get_by_isbn isbn }
  end
end
