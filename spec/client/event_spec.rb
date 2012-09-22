# encoding: utf-8

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @event_id = 10055446
    @client = Doufuru::Client.new(:access_token => @access_token)
  end

  describe ".event" do
    context "with a id passed" do
      it "should return the event" do
        stub_get("/event/#{@event_id}").to_return(:body => fixture("event.json"))

        event = @client.event(@event_id)
        event.title = "后海大鲨鱼全国巡演杭州站"
      end
    end
  end
end
