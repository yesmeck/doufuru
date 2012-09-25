# encoding: utf-8

describe Doufuru::Client do
  include_context "initialize client"

  before do
    @discussion_id = 11676229
    @discussion_title =  "温蒂她爹就是虎克船长- =？"
  end

  describe ".discussion" do
    context "with a id passed" do
      it "should return the discussion" do
        stub_get("/discussion/#{@discussion_id}").to_return(:body => fixture("discussion.json"))

        discussion = @client.discussion(@discussion_id)
        discussion.title.should eq @discussion_title
      end
    end
  end
end
