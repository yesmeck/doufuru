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

  describe ".search_musics" do
    context "with a keyword passed" do
      it "should return the matching musics" do
        pending("豆瓣又返回 500")
        params = {:q => @music_title, :start => 0, :count => 10}
        stub_get("/music/search").
          with(:query => params).
          to_return(:body > fixture("musics.json"))

        musics = @client.search_musics(params)
        musics.first.title.should == @music_title
      end
    end

    context "with a tag passed" do
      it "should return the matching musics" do
        pending("豆瓣又返回 500")
        params = {:tag => @music_title, :start => 0, :count => 10}
        stub_get("/music/search").
          with(:query => params).
          to_return(:body > fixture("musics.json"))

        musics = @client.search_musics(params)
        musics.first.title.should == @music_title
      end
    end
  end

  describe ".music_tags" do
    context "with a music id passed" do
      it "should return a tag list of the music" do
        stub_get("/music/#{@music_id}/tags").
          to_return(:body => fixture("music_tags.json"))

        music_tags = @client.music_tags(@music_id)
        music_tags.first.title.should == "MyChemicalRomance"
      end
    end
  end
end

