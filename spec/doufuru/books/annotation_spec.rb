# encoding: utf-8

require "spec_helper"

describe Doufuru::Books, "#annotation" do

  let(:id) { 12922455 }
  let(:request_path) { "/book/annotation/#{id}" }

  before do
    stub_get(request_path).to_return(:body => fixture("books/annotation.json"))
  end

  it "should request the annotation" do
    subject.annotation id
    a_get(request_path).should have_been_made
  end

  it "should get the annotation" do
    annotation = subject.annotation id
    annotation.book.title.should == "JavaScript语言精粹"
  end

end