# encoding: utf-8

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @event_id = 10055446
    @event_title = "又是一年世界滑板日！！！！！"
    @user_id = "coolzi"
    @loc_id = 118159
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

  describe ".event_user_created" do
    context "with a user id passed" do
      it "should return a events list that the user created" do
        stub_get("/event/user_created/#{@user_id}").to_return(:body => fixture("events.json"))

        events = @client.event_user_created(@user_id)
        events.first.title.should eq @event_title
      end
    end
  end

  describe ".event_user_participanted" do
    context "with a user id passed" do
      it "should return a events list that the user participanted" do
        stub_get("/event/user_participanted/#{@user_id}").to_return(:body => fixture("events.json"))

        events = @client.event_user_participanted(@user_id)
        events.first.title.should eq @event_title
      end
    end
  end

  describe ".event_user_wished" do
    context "with a user id passed" do
      it "should return a events list that the user wished" do
        stub_get("/event/user_wished/#{@user_id}").to_return(:body => fixture("events.json"))

        events = @client.event_user_wished(@user_id)
        events.first.title.should eq @event_title
      end
    end
  end

  describe ".event_list" do
    it "should return a event list" do
      params = { :loc => @loc_id, :day_type => "todau", :type => "music" }
      stub_get("/event/list").
        with(:query => params).
        to_return(:body => fixture("events.json"))

      events = @client.event_list(params)
      events.first.title.should eq @event_title
    end
  end

  describe ".loc" do
    context "with a location id passed" do
      it "should return the location" do
        stub_get("/loc/#{@loc_id}").to_return(:body => fixture("loc.json"))

        loc = @client.loc(@loc_id)
        loc.name.should eq "南京"
      end
    end
  end

  describe ".loc_list" do
    it "should return the location list" do
      stub_get("/loc/list").to_return(:body => fixture("locs.json"))

      locs = @client.loc_list
      locs.first.name.should eq "北京"
    end
  end

  describe ".participate_event" do
    context "with a event id passed" do
      pending("神奇的豆瓣居然返回 null")
      it "should let oauthed user participate the event" do
        params = {:participate_date => "2012-12-21"}
        stub_post("/event/#{@event_id}/participants").
          with(:query => params, :headers => {"Authorization" => "Bearer #{@access_token}"}).
          to_return(:body => nil)
      end
    end
  end
end
