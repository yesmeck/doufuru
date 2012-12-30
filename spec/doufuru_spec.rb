# encoding: utf-8

require "spec_helper"

describe Doufuru do
  it "should respond to 'new' message" do
    subject.should respond_to :new
  end

  it "should recieve 'new' and initialize subject::Client instance" do
    subject.new.should be_a Doufuru::Client
  end

  it "should responde to 'configure' message" do
    subject.should respond_to :configure
  end

  describe "setting configuration options" do
    it "should return default adapter" do
      subject.adapter.should == Doufuru::Configuration::DEFAULT_ADAPTER
    end

    it "should allow to set adapter" do
      subject.adapter = :typhoeus
      subject.adapter.should == :typhoeus
    end

    it "should allow to set endpoint" do
      subject.endpoint = "http://api.xxx.com"
      subject.endpoint.should == "http://api.xxx.com"
    end

    it "should return the default user agent" do
      subject.user_agent.should == Doufuru::Configuration::DEFAULT_USER_AGENT
    end

    it "should allow to set new user agent" do
      subject.user_agent = "New user agent"
      subject.user_agent.should == "New user agent"
    end

    it "should have not set oauth token" do
      subject.oauth_token.should be_nil
    end

    it "should allow to set oauth token" do
      subject.oauth_token = "newtoken"
      subject.oauth_token.should == "newtoken"
    end

    it "should have not set default user" do
      subject.user.should be_nil
    end

    it "should allow to set new user" do
      subject.user = "coolzi"
      subject.user.should == "coolzi"
    end
  end

  describe ".configure" do
    Doufuru::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Doufuru.configure do |config|
          config.send("#{key}=", key)
          Doufuru.send(key).should == key
        end
      end
    end
  end
end
