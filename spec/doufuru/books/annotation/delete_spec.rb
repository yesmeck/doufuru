# encoding: utf-8

require "spec_helper"

describe Doufuru::Books::Annotation, "#delete" do

  include_context "set oauth info"

  let(:id) { 12922455 }
  let(:request_path) { "/book/annotation/#{id}" }

  before do
    Doufuru.configure do |config|
      config.oauth_token = oauth_token
    end
    stub_delete(request_path).with(:headers => oauth_header)
                          .to_return(:status => 204, :body => "")
  end

  after { reset_authentication_for subject }

  it "should create a delete request" do
    subject.delete id
    a_delete(request_path).with(:headers => oauth_header).should have_been_made
  end

  it "should  delete the annotation" do
    result = subject.delete id
    result.should be_true
  end

end
