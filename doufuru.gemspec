# encoding: utf-8

require File.expand_path("../lib/doufuru/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "doufuru"
  s.description = "Simple Ruby wrapper for the Douban v2 API"
  s.authors = ["Wei Zhu"]
  s.email = ["yesmeck@gmail.com"]
  s.files = `git ls-files`.split("\n")
  s.homepage = "https://github.com/yesmeck/doufuru"
  s.summary = s.description
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = Doufuru::VERSION::STRING

  s.add_dependency "faraday", '~> 0.8.8'
  s.add_dependency "faraday_middleware", '~> 0.9.0'
  s.add_dependency "oauth2", '~> 0.9.2'
  s.add_dependency "hashie", '~> 2.0.5'
  s.add_dependency "mime-types", '~> 1.25'
  s.add_dependency "multi_json", '~> 1.8.0'

  s.add_development_dependency "json", '~> 1.8.0'
  s.add_development_dependency "rake", '~> 10.1.0'
  s.add_development_dependency "rspec", '~> 2.14.1'
  s.add_development_dependency "guard-rspec", '~> 3.1.0'
  s.add_development_dependency "webmock", '~> 1.13.0'
  s.add_development_dependency "pry-nav", '~> 0.2.3'
end
