# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @music_id = 1899400
    @music_title = "The Black Parade"
    @client = Doufuru::Client.new(:access_token => @access_token)
  end

  describe ".music" do
    context "with a id passed" do
      it "should return the music info" do
        stub_get("/music/#{@music_id}").to_return(:body => fixture("music.json"))

        music = @client.music(@music_id)
        music.title.should == @music_title
      end
    end
  end
end

