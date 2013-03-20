require 'snorkeler/error/client_error'

module Snorkeler
  class Error
    # Raised when Snorkle returns the HTTP status code 404
    class NotFound < Snorkeler::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end
