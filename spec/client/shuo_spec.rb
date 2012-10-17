# encoding: utf-8

require "spec_helper"

describe Doufuru::Client::Shuo do
  include_context "initialize client"

  before do
    Doufuru.configure do |c|
      c.api_key = 'myfakeapikey'
    end
    @text = "测试"
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
end
