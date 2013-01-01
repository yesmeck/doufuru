# encoding: utf-8

require "spec_helper"

describe Doufuru::Books::Collection, "#create" do

  include_context "set oauth info"

  let(:id) { 1084336 }
  let(:request_path) { "/book/#{id}/collection" }
  let(:content) { {:status => "read"} }

  before do
    stub_post(request_path).with(:content => content).to_return(:body => fixture("books/collection.json"))
  end

  it "should create a post" do
    subject.create id, content
    a_post(request_path).with(:content => content, :header => oauth_header).should have_been_made
  end

  it "should mark the book as read" do
    collection = subject.create id, content
    collection.status.should == "read"
  end

end
