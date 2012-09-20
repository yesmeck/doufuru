# encoding: utf-8

require "helper"

describe Doufuru::Client::User do
  before do
    @client = Doufuru::Client.new
  end

  describe ".user" do
    context "with a uid passed" do
      it "should return the user" do
        stub_get("/user/coolzi").to_return(:body => fixture("user.json"))
        user = @client.user("coolzi")
        user.uid.should == "coolzi"
      end
    end

    context "without a uid passed" do
      it "should return the oauthed user" do
        stub_get("/user/~me").to_return(:body => fixture("user.json"))
        user = @client.user
        user.uid.should == "coolzi"
      end
    end
  end
end
