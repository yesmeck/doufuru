# encoding: utf-8

require "spec_helper"

describe Doufuru::Book::Collection, "#delete" do

  include_context "set oauth info"

  let(:id) { 1084336 }
  let(:request_path) { "/book/#{id}/collection" }

  before do
    stub_delete(request_path).to_return(:status => 204)
  end

  it "create a delete request" do
    subject.delete id
    a_delete(request_path).should have_been_made
  end

  it "should delete the collection" do
     result = subject.delete id
     result.should be_true
  end

end
