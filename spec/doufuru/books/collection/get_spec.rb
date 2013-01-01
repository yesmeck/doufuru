# encoding: utf-8

require "spec_helper"

describe Doufuru::Books::Collection, "#get" do

  include_context "set oauth info"

  let(:id) { 1084336 }
  let(:request_path) { "/book/#{id}/collection" }

  before do
    Doufuru.configure do |config|
      config.oauth_token = oauth_token
    end
    stub_get(request_path).to_return(:body => fixture("books/collection.json"))
  end

  after do
    reset_authentication_for subject
  end

  it "should request user collection status" do
    subject.get id
    a_get(request_path).with(:headers => oauth_header)
  end

  it "should return current oauthed user's collection status of book" do
    collection = subject.get id
    collection.status.should == "read"
  end

end
