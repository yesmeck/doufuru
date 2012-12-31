# encoding: utf-8

require "spec_helper"

describe Doufuru::Books::User, "#annotations" do

  let(:user) { "coolzi" }
  let(:request_path) { "/book/user/#{user}/annotations" }

  before do
    stub_get(request_path).to_return(:body => fixture("books/user/annotations.json"))
  end

  it "should request annotations of book" do
    subject.annotations user
    a_get(request_path).should have_been_made
  end

  it "should get user annotations of book" do
    annotations = subject.annotations user
    annotations.first.chapter.should == "Function"
  end

end
