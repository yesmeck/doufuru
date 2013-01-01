# encoding: utf-8

require "spec_helper"

describe Doufuru::Books, "#annotation" do

  let(:id) { 12922455 }
  let(:request_path) { "/book/annotation/#{id}" }

  context "with id passed" do

    before do
      stub_get(request_path).to_return(:body => fixture("books/annotation/get.json"))
    end

    it "should request the annotation" do
      subject.annotation id
      a_get(request_path)
    end

  end

  context "without id passed" do

    it "should return a instance of Doufuru::Books::Collection" do
      subject.annotation.should be_a Doufuru::Books::Annotation
    end

  end

end
