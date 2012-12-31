# encoding: utf-8

require "spec_helper"

describe Doufuru::Books, "#tag" do

  let(:id) { 1084336 }
  let(:request_path) { "/book/#{id}/tags" }
  let(:body) { fixture("books/tags.json") }

  before do
    stub_get(request_path).to_return(:body => body)
  end

  it "should request the tags" do
    subject.tags id
    a_get(request_path).should have_been_made
  end

  it "should return tags of the book" do
    tags = subject.tags id
    tags.first.title.should == "小王子"
  end

end
