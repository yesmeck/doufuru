# encoding: utf-8

require "doufuru"
require "rspec"
require "webmock/rspec"


# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/{support,shared}/**/*.rb"].each { |f| require f }

def stub_get(path)
  stub_request(:get, douban_url(path))
end

def stub_post(path)
  stub_request(:post, douban_url(path))
end

def stub_put(path)
  stub_request(:put, douban_url(path))
end

def stub_delete(path)
  stub_request(:delete, douban_url(path))
end

def a_get(path)
  a_request(:get, douban_url(path))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def douban_url(path)
 path.sub!(/^\//, "")
 if path =~ /^shuo/
   path.sub!(/^shuo/, "shuo/v2")
 else
   path = "v2/#{path}"
 end
  "https://api.douban.com/#{path}"
end


def reset_authentication_for(object)
  %w{ oauth_token }.each do |item|
    Doufuru.send("#{item}=", nil)
    object.send("#{item}=", nil)
  end
end
