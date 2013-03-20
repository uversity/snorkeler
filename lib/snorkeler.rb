require "snorkeler/version"
require 'snorkeler/configurable'
require 'snorkeler/client'
require 'snorkeler/default'

module Snorkeler
  class << self
    include Snorkeler::Configurable

    # Delegate to a Snorkeler::Client
    #
    # @return [ Snorkeler::Client]
    def client
      @client =  Snorkeler::Client.new(options) unless defined?(@client) && @client.hash == options.hash
      @client
    end
    # See: http://robots.thoughtbot.com/post/28335346416/always-define-respond-to-missing-when-overriding
    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

Snorkeler.setup