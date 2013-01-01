# encoding: utf-8

require "spec_helper"

describe Doufuru::Books::Annotation, "#list" do

  include_context "set oauth info"

  let(:id) { 3590768 }
  let(:request_path) { "/book/#{id}/annotations" }

  before do
    stub_get(request_path).to_return(:body => fixture("books/annotation/list.json"))
  end

  it "should request user annotations of the book" do
    subject.list id
    a_get(request_path).with(:header => oauth_header).should have_been_made
  end

  it "should get user annotations of the book" do
    annotations = subject.list id
    annotations.first.book.title.should == "JavaScript语言精粹"
  end

end
