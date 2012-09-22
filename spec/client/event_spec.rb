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

  describe ".event_participants" do
    context "with a id passed" do
      it "should return a participants list of the event" do
        stub_get("/event/#{@event_id}/participants").to_return(:body => fixture("event_participants.json"))

        participants = @client.event_participants(@event_id)
        participants.first.uid.should eq "yizhengcc"
      end
    end
  end

  describe ".event_wishers" do
    context "with a id passed" do
      it "should return a wishers list of the event" do
        stub_get("/event/#{@event_id}/wishers").to_return(:body => fixture("event_wishers.json"))

        wishers = @client.event_wishers(@event_id)
        wishers.first.uid.should eq "loni1227"
      end
    end
  end
end
