# encoding: utf-8

require "helper"

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @movie_id = 1307931
    @movie_title = "Peter Pan"
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
end
