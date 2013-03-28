require 'forwardable'

module Snorkeler
  module Configurable
    extend Forwardable
    attr_accessor :endpoint, :middleware, :connection_options
    # see http://ruby-doc.org/stdlib-1.9.3/libdoc/forwardable/rdoc/Forwardable.html
    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :endpoint,
          :middleware,
          :connection_options
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    #
    # @raise [ Snorkeler::Error::ConfigurationError] Error is raised when supplied
    #    Snorkeler options are not a String or Symbol.
    def configure
      yield self
      self
    end

    def options
      Hash[ Snorkeler::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    def reset!
      Snorkeler::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Snorkeler::Default.options[key])
      end
      self
    end

    alias setup reset!

  end
end
