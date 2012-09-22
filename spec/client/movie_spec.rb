# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @movie_id = 1307931
    @movie_title = "Peter Pan"
    @imdb = "tt0316396"
    @review_title = "测试"
    @review_content = "因为，绳命，是剁么的回晃；绳命，是入刺的井猜。壤窝们，巩痛嘱咐碰优。田下冯广宰饿妹，饿妹冯广宰呲处。壤窝们，嘱咐这缩优类缩优。开心的一小，火大的一小，壤绳命，梗楤容，壤绳命，梗秤巩，壤绳命，梗回晃。"
    @rating = "5"
    @client = Doufuru::Client.new(:access_token => @access_token)
  end

  describe ".movie" do
    context "with a id passed" do
      it "should return the movie" do
        stub_get("/movie/#{@movie_id}").to_return(:body => fixture("movie.json"))

        movie = @client.movie(@movie_id)
        movie.title.should == @movie_title
      end
    end
  end

  describe ".movie_by_imdb" do
    context "with a imdb passed" do
      it "should return the movie" do
        stub_get("/movie/imdb/#{@imdb}").to_return(:body => fixture("movie.json"))

        movie = @client.movie_by_imdb(@imdb)
        movie.title.should == @movie_title
      end
    end
  end

  describe ".search_movies" do
    context "with a keyword passed" do
      it "should return the matching movies" do
        params = {:q => @movie_title, :start => 0, :count => 10};
        stub_get("/movie/search").with(:query => params).to_return(:body => fixture("movies.json"))

        movies = @client.search_movies(params)
        movies.first.title == @movie_title
      end
    end

    context "with a tag passed" do
      it "should return the matching movies" do
        params = {:tag => @movie_title, :start => 0, :count => 10};
        stub_get("/movie/search").with(:query => params).to_return(:body => fixture("movies.json"))

        movies = @client.search_movies(params)
        movies.first.title == @movie_title
      end
    end
  end

  describe ".movie_tags" do
    context "with a movie id passed" do
      it "should return a tag list" do
        stub_get("/movie/#{@movie_id}/tags").to_return(:body => fixture("movie_tags.json"))

        movie_tags = @client.movie_tags(@movie_id)
        movie_tags.first.title.should == "童话"
      end
    end
  end

  describe ".create_movie_review" do
    it "should create a movie review" do
      pending("豆瓣接口口有问题 http://www.douban.com/group/topic/32964168/")
      stub_post("/movie/reviews").with(
        :content => {
          :movie => @movie_id,
          :title => @review_title,
          :content => @review_content,
          :rating => @rating
        },
        :headers => {
          "Authorization" => "Bearer #{@access_token}"
        }
      ).to_return(:body => fixture("movie_review_create.json"))
      review = @client.create_movie_review({
        :movie => @movie_id,
        :title => @review_title,
        :content => @review_content,
        :rating => @rating
      })
      review.movie.title.should == @movie_title
      review.title.should == @review_title
      review.content.should == @review_content
      review.rating.value.should == @rating
    end
  end
end
