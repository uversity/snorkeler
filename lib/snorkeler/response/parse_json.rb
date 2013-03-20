require 'faraday'
require 'multi_json'

module Snorkeler
  module Response
    class ParseJson < Faraday::Response::Middleware

      def parse(body)
        #binding.pry
        case body
        when /\A^\s*$\z/, nil
          nil
        when /ERRORINSERTED/
          {message: "INSERTED"}
        else
          MultiJson.decode(body, :symbolize_keys => true)
        end
      end

      def on_complete(env)
        if respond_to?(:parse)
          env[:body] = parse(env[:body]) unless [204, 301, 302, 304].include?(env[:status])
        end
      end

    end
  end
end