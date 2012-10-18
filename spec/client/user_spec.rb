# encoding: utf-8

require "spec_helper"

describe Doufuru::Client::User do
  include_context "initialize client"

  before do
    @uid = "coolzi"
  end

  describe ".user" do
    context "with a uid passed" do
      it "should return the user" do
        stub_get("/user/#{@uid}").to_return(:body => fixture("user.json"))
        user = @client.user(@uid)
        user.uid.should == @uid
      end
    end

    context "without a uid passed" do
      it "should return the oauthed user" do
        stub_get("/user/~me").to_return(
          :body => fixture("user.json"),
          :headers => { "Authorization" => "Bearer #{@access_token}" }
        )
        user = @client.user
        user.uid.should == @uid
      end
    end
  end

  describe ".search_users" do
    context "with a keyword passed" do
      it "should return matching users" do
        stub_get("/user").
          with(:query => { :q => @uid, :start => 0, :count => 10 }).
          to_return(:body => fixture("users.json"))
        user = @client.search_users({ :q => @uid, :start => 0, :count => 10 })
        user.first.uid.should == @uid
      end
    end
  end

  describe ".user_following" do
    context "with a user id passed" do
      it "should return the user's following list." do
        stub_get("/shuo/users/#{@uid}/following").
          to_return(:body => fixture("user_following.json"))

        users = @client.user_following(@uid)
        users.first.uid.should eq "zhutousecretary"
      end
    end
  end

  describe ".user_follow_in_common" do
    context "with a user id passed" do
      it "should return users that the user and current oauthed user followed in common." do
        pending("豆瓣返回 invalid_request_uri")
      end
    end
  end

  describe ".user_suggestions" do
    context "with a user id passed" do
      it "should return users that current oauthed user following and followed the user." do
        pending("豆瓣返回 invalid_request_uri，文档地址也是错的。")
      end
    end
  end
end
