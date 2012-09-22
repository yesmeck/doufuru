# encoding: utf-8

require "doufuru"
require "rspec"
require "webmock/rspec"


def stub_get(url)
  stub_request(:get, douban_url(url))
end

def stub_post(url)
  stub_request(:post, douban_url(url))
end

def stub_put(url)
  stub_request(:put, douban_url(url))
end

def stub_delete(url)
  stub_request(:delete, douban_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def douban_url(url)
  "https://api.douban.com/v2#{url}"
end
