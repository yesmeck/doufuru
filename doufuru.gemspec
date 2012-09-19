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
  s.version = Doufuru::VERSION
end
