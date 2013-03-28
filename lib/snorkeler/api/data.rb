require 'snorkeler/error/forbidden'
require 'snorkeler/error/not_found'


module Snorkeler
  module API
    module Data
      def import params
        send(:post, "/data/import", params).env[:body]
      end
    end
  end
end
