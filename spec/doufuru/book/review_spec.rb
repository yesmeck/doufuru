# encoding: utf-8

require "spec_helper"

describe Doufuru::Book, "#review" do

  context "with a id passed" do
    let(:id) { 5723665 }
    let(:request_path) { "/book/review/#{id}" }

    before do
      stub_get(request_path).to_return(:body => fixture("book/review/get.json"))
    end

    it "should create a get request" do
      subject.review id
      a_get(request_path).should have_been_made
    end

    it "should get the review" do
      review =  subject.review id
      review.title.should == "test"
    end
  end

  context "without a id passed" do
    it "should return a instance of Doufuru::Book::Review" do
      subject.review.should be_a Doufuru::Book::Review
    end
  end

end
