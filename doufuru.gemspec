# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doufuru/version'

Gem::Specification.new do |spec|
  spec.name          = "doufuru"
  spec.version       = Doufuru::VERSION.dup
  spec.authors       = ["Wei Zhu"]
  spec.email         = ["yesmeck@gmail.com"]
  spec.description   = %q{Simple wrapper for Douban API v2}
  spec.summary       = %q{Ruby toolkit for working with the Douban API v2}
  spec.homepage      = "https://github.com/yesmeck/doufuru"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sawyer', '~> 0.5.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
