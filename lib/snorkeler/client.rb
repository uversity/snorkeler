require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'multi_json'
require 'snorkeler/api/data'
require 'snorkeler/configurable'
require 'snorkeler/error/client_error'
require 'snorkeler/error/decode_error'
require 'uri'

module Snorkeler
  # Wrapper for the Snorkeler REST API
  class Client
    include Snorkeler::API::Data
    include Snorkeler::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Snorkeler::Client]
    def initialize(options={})
      Snorkeler::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Snorkeler.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      request(:post, path, params)
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

  private

    def request(method, path, params={})
      connection.send method.to_sym, path, params
    rescue Faraday::Error::ClientError
      raise Snorkeler::Error::ClientError
    rescue MultiJson::DecodeError
      raise Snorkeler::Error::DecodeError
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end

  end
end
