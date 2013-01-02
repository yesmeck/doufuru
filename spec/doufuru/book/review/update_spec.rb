# encoding: utf-8

require "spec_helper"

describe Doufuru::Book::Review, "update" do

  include_context "set oauth info"

  let(:id) { 5723665 }
  let(:request_path) { "/book/review/#{id}" }
  let(:params) { {:title => "test", :content => "test" * 15} }

  before do
    Doufuru.configure do |config|
      config.oauth_token = oauth_token
    end
    stub_put(request_path).with(:content => params, :headers => oauth_header).
      to_return(:body => fixture("book/review/get.json"))
  end

  after { reset_authentication_for subject }

  it "should create a put request" do
    subject.update id, params
    a_put(request_path).with(:content => params, :headers => oauth_header).should have_been_made
  end

  it "should update the review" do
    review = subject.update id, params
    review.title.should == params["title"]
  end

end
