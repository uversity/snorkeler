require 'faraday'
require 'faraday_middleware'
require 'snorkeler/configurable'
require 'snorkeler/error/client_error'
require 'snorkeler/error/server_error'
require 'snorkeler/response/parse_snorkle_response'
require 'snorkeler/response/raise_error'
require 'snorkeler/version'

module Snorkeler
  module Default
    ENDPOINT = 'https://localhost:3001' unless defined? Snorkeler::Default::ENDPOINT
    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "Snorkeler Ruby Gem #{Snorkeler::Version}",
      },
      :request => {
        :open_timeout => 5,
        :timeout => 10,
      },
      :ssl => {
        :verify => false
      },
    } unless defined? Snorkeler::Default::CONNECTION_OPTIONS
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Encode Json
      builder.use FaradayMiddleware::EncodeJson
      # Encode Json
      builder.use FaradayMiddleware::EncodeJson
      # Handle 4xx server responses
      builder.use Snorkeler::Response::RaiseError, Snorkeler::Error::ClientError
      # Parse JSON response bodies using MultiJson
      builder.use Snorkeler::Response::ParseSnorkleResponse
      # Handle 5xx server responses
      builder.use Snorkeler::Response::RaiseError, Snorkeler::Error::ServerError

      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end unless defined? Snorkeler::Default::MIDDLEWARE

    class << self

      # @return [Hash]
      def options
        Hash[Snorkeler::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def endpoint
        ENDPOINT
      end

      def connection_options
        CONNECTION_OPTIONS
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end
    end
  end
end
