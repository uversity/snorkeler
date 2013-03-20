require 'snorkeler/error/client_error'

module Snorkeler
  class Error
    # Raised when Snorkle returns the HTTP status code 403
    class Forbidden < Snorkeler::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end
