# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fake_consul/version'

Gem::Specification.new do |spec|
  spec.name          = "fake_consul"
  spec.version       = FakeConsul::VERSION
  spec.authors       = ["Saimon Moore"]
  spec.email         = ["saimonmoore@gmail.com"]
  spec.summary       = %q{Fakes a consul server. Usecase is for feature specs using Diplomat client}
  spec.description   = %q{Fakes a consul server. Usecase is for feature specs using Diplomat client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 3.2.21"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
