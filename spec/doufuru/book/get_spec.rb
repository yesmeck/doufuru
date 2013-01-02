# encoding: utf-8

require "spec_helper"

describe Doufuru::Book, "#get" do

  let(:id) { 1084336 }
  let(:request_path) { "/book/#{id}" }

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

    it { should respond_to :find }

    it "should raise error when no id parameter" do
      expect { subject.get nil }.to raise_error(ArgumentError)
    end

    it "should find book" do
      subject.get id
      a_get(request_path).should have_been_made
    end

    it "should return book mash" do
      book = subject.get id
      book.should be_a Hashie::Mash
    end

    it "should get book information" do
      book = subject.get id
      book.title.should == "小王子"
    end
  end

  it_should_behave_like "request failure" do
    let(:requestable) { subject.get id }
  end

end
