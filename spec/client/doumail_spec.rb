# encoding: utf-8

describe Doufuru::Client do
  include_context "initialize client"

  before do
    @doumail_id = 268610725
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

  describe ".doumail_inbox_unread" do
    it "return a unread doumail list of the oauthed user's inbox" do
      pending("破豆瓣，又请求不到!")
      stub_get("/doumail/inbox/unread").
        with(:headers => "Authorization: Bearer #{myfaketoken}").
        to_return(:body => fixture("doumails.json"))

      doumails = @client.doumail_outbox
    end
  end

  describe ".mark_doumail_as_read" do
    context "with a doumail id passed" do
      it "should mark the doumail as read" do
        pending("破豆瓣，又请求不到!")
        stub_put("/doumail/#{@doumail_id}").
          with(:headers => "Authorization: Bearer #{myfaketoken}").
          to_return(:body => fixture("wtf.json"))
      end
    end
  end

  describe ".mark_doumails_as_read" do
    context "with doumail ids passed" do
      it "should mark them as read" do
        pending("破豆瓣，又请求不到!")
        stub_put("/doumail/read").
          with(
            :content => { :ids => @doumail_id },
            :headers => "Authorization: Bearer #{myfaketoken}"
          ).
          to_return(:body => fixture("wtf.json"))
      end
    end
  end

  describe ".delete_doumail" do
    context "with a id passed" do
      it "should delete the doumail" do
        pending("破豆瓣，又请求不到!")
        stub_delete("/doumail/#{@doumail_id}").
          with(:headers => "Authorization: Bearer #{myfaketoken}").
          to_return(:body => fixture("wtf.json"))
      end
    end
  end

  describe ".delete_doumails" do
    context "with a list of doumail ids passed" do
      it "should delete the doumail" do
        pending("破豆瓣，又请求不到!")
        stub_post("/doumail/delete").
          with(
            :content => { :ids => @doumail_id },
            :headers => "Authorization: Bearer #{myfaketoken}"
          ).
          to_return(:body => fixture("wtf.json"))
      end
    end
  end

  describe ".send_doumail" do
    it "should send a doumail to the user" do
      pending("破豆瓣，又请求不到!")
      params = { :title => "测试", :content => "测试", :receiver_id => "hualunlun" }
      stub_post("/doumails").
        with( :query => params, :headers => "Authorization: Bearer #{myfaketoken}")
    end
  end
end