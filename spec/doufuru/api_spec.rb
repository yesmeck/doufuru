# encoding: utf-8

require "spec_helper"

describe Doufuru::API do
  let(:api) { Doufuru::API.new }
  let(:books) { Doufuru::Books }

  describe "actions" do
    it { described_class.new.should respond_to :api_methods_in }
  end

  it "dynamically adds actions inspection to classed inheriting from api" do
    books.should respond_to :actions
    books.new.should respond_to :actions
  end

  it "ensures output contains api methods" do
    methods = [ "method_a", "method_b" ]
    books.stub(:instance_methods).and_return methods
    output = capture(:stdout) { api.api_methods_in(books) }
    output.should =~ /.*method_a.*/
    output.should =~ /.*method_b.*/
  end

  describe "_set_api_client" do
    it "should set instaniated api class as main api client" do
      books_instance = books.new
      Doufuru::api_client.should == books_instance
    end
  end

  describe "normalize!" do
    before do
      @params = { "a" => { :b => { "c" => 1 }, "d" => [ "a", { :e => 2 }] } }
    end

    it "should stringify all the keys inside nested hash" do
      actual = api.normalize! @params
      expected = { "a" => { "b"=> { "c" => 1 }, "d" => [ "a", { "e"=> 2 }] } }
      actual.should be_eql expected
    end
  end

  describe "filter!" do
    it "should remove non valid param keys" do
      valid = ["a", "b", "e"]
      hash = {"a" => 1, "b" => 3, "c" => 2, "d"=> 4, "e" => 5 }
      actual = api.filter! valid, hash
      expected = {"a" => 1, "b" => 3, "e" => 5 }
      actual.should be_eql expected
    end
  end
end
