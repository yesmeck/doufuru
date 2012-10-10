# encoding: utf-8

require "spec_helper"

describe Doufuru::Client do
  include_context "initialize client"

  before do
    @discussion_id = 11676229
    @discussion_title =  "温蒂她爹就是虎克船长- =？"
    @discussion_content = "测试内容"
    @target_id = 1307931
  end

  describe ".discussion" do
    context "with a id passed" do
      it "should return the discussion" do
        stub_get("/discussion/#{@discussion_id}").to_return(:body => fixture("discussion.json"))

        discussion = @client.discussion(@discussion_id)
        discussion.title.should eq @discussion_title
      end
    end
  end

  describe ".update_discussion" do
    context "with a id passed" do
      it "should update the discussion" do
        stub_put("/discussion/#{@discussion_id}").
          with(
            :content => { :title => @discussion_title, :content => @discussion_content },
            :headers => { "Authorization" => "Bearer #{@access_token}" }
          ).
          to_return(:body => fixture("discussion_update.json"))

        discussion = @client.update_discussion(@discussion_id)
        discussion.title.should eq @discussion_title
        discussion.content.should eq @discussion_content
      end
    end
  end

  describe ".delete_discussion" do
    context "with a id passed" do
      it "should delete the discussion" do
        stub_delete("/discussion/#{@discussion_id}").
          with( :headers => { "Authorization" => "Bearer #{@access_token}" }).
          to_return(:body => "{}")

        response = @client.delete_discussion(@discussion_id)
        response.should eq "ok"
      end
    end
  end

  describe ".create_discussion" do
    context "with a target id passed" do
      it "should create a new discussion of the target" do
        pending("豆瓣返回 invalid_request_uri")
        stub_post("/target/#{@target_id}/discussions").
          with(
            :content => { :title => @discussion_title, :content => @discussion_content },
            :headers => { "Authorization" => "Bearer #{@access_token}" }
          ).
          to_return(:body => fixture("discussion_create.json"))

        discussion = @client.create_discussion(@target_id)
        discussion.title.should eq @discussion_title
        discussion.content.should eq @discussion_content
      end
    end
  end

  describe ".discussion_list" do
    context "with a target id passed" do
      it "should return a discussion list of the target" do
        pending("豆瓣返回 404")
        stub_get("/target/#{@target_id}/discussions").
          to_return(:body => fixture("discussions.json"))
      end
    end
  end
end
