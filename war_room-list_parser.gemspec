# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'war_room/list_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "war_room-list_parser"
  spec.version       = WarRoom::ListParser::VERSION
  spec.authors       = ["Dan Erikson"]
  spec.email         = ["derikson3@gmail.com"]
  spec.summary       = %q{Parser for War Room lists.}
  spec.description   = %q{Parser for War Room lists created through the "email army" feature.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet", "~> 1.6"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
