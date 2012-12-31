# encoding: utf-8

require "spec_helper"

describe Doufuru::Books, "#user_tags" do

  let(:user) { "coolzi" }
  let(:request_path) { "/book/user/#{user}/tags" }

  before do
    stub_get(request_path).to_return(:body => fixture("books/user_tags.json"))
  end

  it "should get user tags of book" do
    tags = subject.user_tags user
    tags.first.title.should == "余华"
  end
end
