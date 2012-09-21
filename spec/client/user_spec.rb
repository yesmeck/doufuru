# encoding: utf-8

require "helper"

describe Doufuru::Client::User do
  before do
    @access_token = "myfaketoken"
    @client = Doufuru::Client.new(:access_token => @access_token)
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
        stub_get("/user/~me").to_return(
          :body => fixture("user.json"),
          :headers => { "Authorization" => "Bearer #{@access_token}" }
        )
        user = @client.user
        user.uid.should == "coolzi"
      end
    end
  end

  describe ".search_users" do
    context "with a keyword passed" do
      it "should return matching users" do
        stub_get("/user").
          with(:query => { :q => "coolzi", :start => 0, :count => 10 }).
          to_return(:body => fixture("users.json"))
        user = @client.search_users({ :q => "coolzi", :start => 0, :count => 10 })
        user.first.uid.should == "coolzi"
      end
    end
  end
end
