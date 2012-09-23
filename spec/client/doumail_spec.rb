# encoding: utf-8

describe Doufuru::Client do
  before do
    @access_token = "myfaketoken"
    @doumail_id = 268610725
    @client = Doufuru::Client.new(:access_token => @access_token)
  end

  describe ".doumail" do
    context "with a id passed" do
      it "should return the doumail" do
        pending("又请求不到。。。")
        stub_get("/doumail/#{@doumail}").
          with(:headers => "Authorization: Bearer #{myfaketoken}").
          to_return(:body => fixture("doumail.json"))

        doumail = @client.doumail(@doumail_id)
      end
    end
  end

  describe ".doumail_inbox" do
    it "return a doumail list of oauthed user's inbox" do
      pending("破豆瓣，又请求不到!")
      stub_get("/doumail/inbox").
        with(:headers => "Authorization: Bearer #{myfaketoken}").
        to_return(:body => fixture("doumails.json"))

      doumails = @client.doumail_inbox
    end
  end

  describe ".doumail_outbox" do
    it "return a doumail list of the oauthed user's outbox" do
      pending("破豆瓣，又请求不到!")
      stub_get("/doumail/outbox").
        with(:headers => "Authorization: Bearer #{myfaketoken}").
        to_return(:body => fixture("doumails.json"))

      doumails = @client.doumail_outbox
    end
  end
end
