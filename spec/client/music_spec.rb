# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @music_id = 1899400
    @music_title = "The Black Parade"
    @review_title = "测试"
    @review_content = "因为，绳命，是剁么的回晃；绳命，是入刺的井猜。壤窝们，巩痛嘱咐碰优。田下冯广宰饿妹，饿妹冯广宰呲处。壤窝们，嘱咐这缩优类缩优。开心的一小，火大的一小，壤绳命，梗楤容，壤绳命，梗秤巩，壤绳命，梗回晃。"
    @rating = "5"
    @review_id = 5592559
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

  describe ".create_music_review" do
    it "should create a music review" do
      stub_post("/music/reviews").with(
        :content => {
          :music => @music_id,
          :title => @review_title,
          :content => @review_content,
          :rating => @rating
        },
        :headers => {
          "Authorization" => "Bearer #{@access_token}"
        }
      ).to_return(:body => fixture("music_review_create.json"))

      review = @client.create_music_review({
        :music => @music_id,
        :title => @review_title,
        :content => @review_content,
        :rating => @rating
      })
      review.music.title.should == @music_title
      review.title.should == @review_title
      review.content.should == @review_content
      review.rating.value.should == @rating
    end
  end

  describe ".update_music_review" do
    context "with a review id passed" do
      it "should update the review" do
        review_content = "#{@review_content}！"
        stub_put("/music/review/#{@review_id}").with(
          :content => {
            :title => @review_title,
            :content => review_content,
            :rating => @rating
          },
          :headers => {
            "Authorization" => "Bearer #{@access_token}"
          }
        ).to_return(:body => fixture("music_review_update.json"))

        review = @client.update_music_review(@review_id, {
          :title => @review_title,
          :content => review_content,
          :rating => @rating
        })
        review.music.title.should == @music_title
        review.title.should == @review_title
        review.content.should == review_content
        review.rating.value.should == @rating
      end
    end
  end

  describe ".delete_music_review" do
    context "with a review id passed" do
      it "should delete the review" do
        stub_delete("/music/review/#{@review_id}").with(:headers => {
          "Authorization" => "Bearer #{@access_token}"
        }).to_return(:body => "\"OK\"")

        result = @client.delete_music_review(@review_id)
        result.should == "ok"
      end
    end
  end
end

