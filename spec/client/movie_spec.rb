# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @movie_id = 1307931
    @movie_title = "Peter Pan"
    @imdb = "tt0316396"
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
end
