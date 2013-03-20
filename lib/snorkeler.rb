require "snorkeler/version"
require 'snorkeler/configurable'

module Snorkeler
  class << self
    include Snorkeler::Configurable

  end
end

# Snorkeler.setup