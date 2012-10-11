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
        stub_post('/shuo/statuses').
          with(
            :content => params,
            :headers => {
              "Authorization" => "Bearer #{@access_token}"
            }
          ).
          to_return(:body => fixture('shuo_create.json'));
        shuo = @client.create_shuo(params)
        shuo.text.should eq @text
      end
    end
  end
end
