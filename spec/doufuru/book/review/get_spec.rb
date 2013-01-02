# encoding: utf-8

require "spec_helper"

describe Doufuru::Book::Review, "#get" do

  let(:id) { 5723665 }
  let(:request_path) { "/book/review/#{id}" }

  before do
    stub_get(request_path).to_return(:body => fixture("book/review/get.json"))
  end

  it "should create a get request" do
    subject.get id
    a_get(request_path).should have_been_made
  end

  it "should get the review" do
    review =  subject.get id
    review.title.should == "test"
  end

end
