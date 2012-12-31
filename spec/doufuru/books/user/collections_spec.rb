# encoding: utf-8

require "spec_helper"

describe Doufuru::Books::User, "#collections" do

  let(:user) { "coolzi" }
  let(:request_path) { "/book/user/#{user}/collections" }

  before do
    stub_get(request_path).to_return(:body => fixture("books/user/collections.json"))
  end

  it "should request user collections of book" do
    subject.collections user
    a_get(request_path).should have_been_made
  end

  it "should get user collections of book" do
    collections = subject.collections user
    collections.first.book.title.should == "SQL反模式"
  end

end
