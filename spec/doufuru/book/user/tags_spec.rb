# encoding: utf-8

require "spec_helper"

describe Doufuru::Book::User, "#tags" do

  let(:user) { "coolzi" }
  let(:request_path) { "/book/user/#{user}/tags" }

  before do
    stub_get(request_path).to_return(:body => fixture("book/user/tags.json"))
  end

  it "should request user tags of the book" do
    subject.tags user
    a_get(request_path).should have_been_made
  end

  it "should get user tags of book" do
    tags = subject.tags user
    tags.first.title.should == "余华"
  end
end
