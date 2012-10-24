# encoding: utf-8

require "spec_helper"

describe Doufuru::Client::Note do

  include_context "initialize client"

  before do
    @title = "test"
  end

  describe ".create_note" do
    it "should create a new note." do
      params = {
        :title => @title,
        :privacy => 'private',
        :can_reply => 'false',
        :content => 'aha'
      }
      stub_post("/notes").
        with(
          :content => params,
          :headers => {
            "Authorization" => "Bearer #{@access_token}"
          }
        ).
        to_return(:body => fixture("note.json"))

      note = @client.create_note(params)
      note.title.should eq @title
    end
  end
end
