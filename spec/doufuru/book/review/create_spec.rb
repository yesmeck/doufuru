# encoding: utf-8

require "spec_helper"

describe Doufuru::Book::Review, "#create" do

  include_context "set oauth info"

  let(:book_id) { 12922455 }
  let(:request_path) { "/book/reviews" }
  let(:params) { {:book => book_id, :title => "test", :content => "test" * 15} }

  before do
    Doufuru.configure do |config|
      config.oauth_token = oauth_token
    end
    stub_post(request_path).with(:content => params, :headers => oauth_header)
                      .to_return(:body => fixture("book/review/get.json"))

  end

  after { reset_authentication_for subject }

  it "should create a post request" do
    subject.create params
    a_post(request_path).with(:content => params, :headers => oauth_header).should have_been_made
  end

  it "should create a new review" do
    review = subject.create params
    review.title.should == params["title"]
  end

end
