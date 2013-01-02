# encoding: utf-8

require "spec_helper"

describe Doufuru::Book::Annotation, "#update" do

  include_context "set oauth info"

  let(:id) { 12922455 }
  let(:request_path) { "/book/annotation/#{id}" }
  let(:params) { {:content => "test" * 16, :page => 1, :privacy => "private"} }

  before do
    Doufuru.configure do |config|
      config.oauth_token = oauth_token
    end
    stub_put(request_path).with(:content => params, :headers => oauth_header).
      to_return(:body => fixture("book/annotation/create.json"))
  end

  after { reset_authentication_for subject }

  it "should create a put request" do
    subject.update id, params
    a_put(request_path).with(:content => params, :headers => oauth_header).should have_been_made
  end

  it "should update the annotation" do
    annotation = subject.update id, params
    annotation.content.should == params["content"]
  end

end
