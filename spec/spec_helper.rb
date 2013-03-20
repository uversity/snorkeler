require 'rspec'
require 'snorkeler'
require 'pry'
require 'vcr'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
  config.extend VCR::RSpec::Macros
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :faraday
end
