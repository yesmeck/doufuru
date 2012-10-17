# encoding: utf-8

require "spec_helper"

describe Doufuru::Client::Shuo do
  include_context "initialize client"

  before do
    Doufuru.configure do |c|
      c.api_key = 'myfakeapikey'
    end
    @text = "测试"
    @shuo_id = 1027862406
  end

  describe ".create_shuo" do
    context "with a text passed" do
      it "should create a new shuo" do
        params = { :source =>  Doufuru.api_key, :text => @text }
        stub_post('/shuo/statuses/').
          with(
            :content => params,
            :headers => {
              "Authorization" => "Bearer #{@access_token}"
            }
          ).
          to_return(:body => fixture('shuo_create.json'))
        shuo = @client.create_shuo(params)
        shuo.text.should eq @text
      end
    end
  end

  describe ".timeline" do
    it "should return current oauthed user's timeline" do
      stub_get('/shuo/home_timeline').
        with(
          :headers => {
            "Authorization" => "Bearer #{@access_token}"
          }
        ).
        to_return(:body => fixture('shuo_timeline.json'))
        shuos = @client.timeline
        shuos.first.id.should eq 1027895573
    end
  end

  describe ".user_timeline" do
    context "with a user id or screename passed" do
      it "should return the user's timeline." do
        user_id = "coolzi"
        stub_get("/shuo/user_timeline/#{user_id}").to_return(:body => fixture("user_timeline.json"))
        shuos = @client.user_timeline(user_id)
        shuos.first.id.should eq 1027862406
      end
    end
  end

  describe ".shuo" do
    context "with a shuo id passed" do
      it "should return the shuo" do
        stub_get("/shuo/statuses/#{@shuo_id}").to_return(:body => fixture("shuo.json"))
        shuo = @client.shuo(@shuo_id)
        shuo.id.should eq @shuo_id
      end
    end
  end

  describe ".delete_shuos" do
    context "with a shuo id passed" do
      it "should delete the shuo" do
        stub_delete("/shuo/statuses/#{@shuo_id}").
        with(
          :headers => {
            "Authorization" => "Bearer #{@access_token}"
          }
        ).
        to_return(:body => fixture('shuo.json'))

        shuo = @client.delete_shuo(@shuo_id)
        shuo.id.should eq @shuo_id
      end
    end
  end

  describe ".shuo_comments" do
    context "with a shuo id passed" do
      it "should return a comments list of the shuo." do
        shuo_id = 1008730523
        stub_get("/shuo/statuses/#{shuo_id}/comments").
          to_return(:body => fixture("shuo_comments.json"))

        comments = @client.shuo_comments(shuo_id)
        comments.first.id.should eq 141664345
      end
    end
  end

  describe ".create_shuo_comment" do
    it "should create a shuo comment." do
      shuo_id = 1008730523
      params = { :text => "test" }
      stub_post("/shuo/statuses/#{shuo_id}/comments").
        with(
          :content => params,
          :headers => {
            "Authorization" => "Bearer #{@access_token}"
          }
        ).
        to_return(:body => fixture('shuo_comment.json'))

      comment = @client.create_shuo_comment(shuo_id, params)
      comment.id.should eq 144731746
    end
  end

  describe ".shuo_comment" do
    context "with a comment id passed" do
      it "should return the comment" do
        comment_id = 144731746
        stub_get("/shuo/statuses/comment/#{comment_id}").
          to_return(:body => fixture("shuo_comment.json"))

        comment = @client.shuo_comment(comment_id)
        comment.id.should eq comment_id
      end
    end
  end

  describe ".delete_shuo_comment" do
    context "with a comment id passed" do
      it "should delete and return the comment" do
        comment_id = 144731746
        stub_delete("/shuo/statuses/comment/#{comment_id}").
          with(
            :headers => {
              "Authorization" => "Bearer #{@access_token}"
            }
          ).
          to_return(:body => fixture("shuo_comment.json"))

        comment = @client.delete_shuo_comment(comment_id)
        comment.id.should eq comment_id
      end
    end
  end
end
