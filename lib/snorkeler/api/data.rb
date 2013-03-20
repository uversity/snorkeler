require 'snorkeler/api/arguments'
require 'snorkeler/snorkel_response'
require 'snorkeler/error/forbidden'
require 'snorkeler/error/not_found'


module Snorkeler
  module API
    module Data
      def import(dataset, subset, samples)
        send :post, "/data/import", {dataset: dataset, subset: subset, samples: samples}
      end
    end
  end
end