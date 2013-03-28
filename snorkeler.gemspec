# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snorkeler/version'

Gem::Specification.new do |gem|
  gem.name          = "snorkeler"
  gem.version       = Snorkeler::Version
  gem.authors       = ["Josh Deeden, Lane Lillquist"]
  gem.email         = ["engineering@inigral.com"]
  gem.description   = %q{A ruby wrapper for Snorkel}
  gem.summary       = %q{A ruby wrapper for Snorkel}
  gem.homepage      = "http://github.com/inigral/snorkeler"

  # gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.files = %w(.yardopts CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md Rakefile snorkeler.gemspec)
  gem.files += Dir.glob("lib/**/*.rb")
  gem.files += Dir.glob("spec/**/*")
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # runtime dependencies
  gem.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  gem.add_dependency 'faraday_middleware', ['~> 0.9.0']

  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_dependency 'typhoeus', '~> 0.6.2'

  # development dependencies
  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'pry', '>= 0.9.12'
  gem.add_development_dependency "rspec", ["~> 2.13.0"]
  gem.add_development_dependency 'vcr', '~> 2.1.1'
  gem.add_development_dependency 'fakeweb', '~> 1.3.0'
  gem.add_development_dependency 'pry', '~> 0.9.12'

end
