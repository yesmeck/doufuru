# encoding: utf-8

require "spec_helper"

describe Doufuru::Book, "#collection" do

  include_context "set oauth info"

  let(:id) { 1084336 }
  let(:request_path) { "/book/#{id}/collection" }

  context "with id passed" do

    before do
      stub_get(request_path).to_return(:body => fixture("book/collection.json"))
    end

    it "should request the collection status" do
      subject.collection id
      a_get(request_path).with(:headers => oauth_header)
    end

  end

  context "without id passed" do

    it "should return a instance of Doufuru::Book::Collection" do
      subject.collection.should be_a Doufuru::Book::Collection
    end

  end

end
