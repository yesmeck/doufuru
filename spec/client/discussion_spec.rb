# encoding: utf-8

describe Doufuru::Client do
  include_context "initialize client"

  before do
    @discussion_id = 11676229
    @discussion_title =  "温蒂她爹就是虎克船长- =？"
    @discussion_content = "测试内容"
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

  describe ".update_discussion" do
    context "with a id passed" do
      it "should update the discussion" do
        stub_put("/discussion/#{@discussion_id}").
          with(
            :content => { :title => @discussion_title, :content => @discussion_content },
            :headers => { "Authorization" => "Bearer #{@access_token}" }
          ).
          to_return(:body => fixture("discussion_update.json"))

        discussion = @client.update_discussion(@discussion_id)
        discussion.title.should eq @discussion_title
        discussion.content.should eq @discussion_content
      end
    end
  end
end
