require 'forwardable'

module Snorkeler
  module Configurable
    extend Forwardable
    attr_accessor :endpoint
    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :endpoint,
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    #
    # @raise [Twitter::Error::ConfigurationError] Error is raised when supplied
    #   twitter credentials are not a String or Symbol.
    def configure
      yield self
      self
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end


    # alias setup reset!

  end
end