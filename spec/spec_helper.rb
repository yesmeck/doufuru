# encoding: utf-8

require "doufuru"
require "rspec"
require "webmock/rspec"


# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/{support,shared}/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = "random"

  config.include WebmockHelper
  config.include FixturesHelper
  config.include DoubanHelper
end
