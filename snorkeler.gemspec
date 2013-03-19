# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snorkeler/version'

Gem::Specification.new do |gem|
  gem.name          = "snorkeler"
  gem.version       = Snorkeler::VERSION
  gem.authors       = ["Josh Deeden, Lane Lillquist"]
  gem.email         = ["engineering@inigral.com"]
  gem.description   = %q{A ruby wrapper for Snorkel}
  gem.summary       = %q{A ruby wrapper for Snorkel}
  gem.homepage      = "http://github.com/inigral/snorkeler"

  # gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", ["~> 2.13.0"]
end
