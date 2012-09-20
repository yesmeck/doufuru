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
  end
end
