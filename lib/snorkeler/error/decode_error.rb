require 'snorkeler/error'

module Snorkeler
  class Error
    # Raised when JSON parsing fails
    class DecodeError < Snorkeler::Error
    end
  end
end
