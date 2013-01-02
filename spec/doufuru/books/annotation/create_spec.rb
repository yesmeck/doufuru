# encoding: utf-8

require "spec_helper"

describe Doufuru::Books::Annotation, "#create" do

  include_context "set oauth info"

  let(:book_id) { 12922455 }
  let(:request_path) { "/book/#{book_id}/annotations" }
  let(:params) { {:content => "test" * 16, :page => 1, :privacy => "private"} }

  before do
    Doufuru.configure do |config|
      config.oauth_token = oauth_token
    end
    stub_post(request_path).with(:content => params, :headers => oauth_header)
                           .to_return(:body => fixture("books/annotation/create.json"))
  end

  after { reset_authentication_for subject }

  it "should create a post request" do
    subject.create book_id, params
    a_post(request_path).with(:content => params, :headers => oauth_header).should have_been_made
  end

  it "should create a new annotation" do
    annotation = subject.create book_id, params
    annotation.content.should == params["content"]
  end

end
