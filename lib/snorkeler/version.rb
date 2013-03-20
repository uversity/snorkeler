module Snorkeler
  class Version
    MAJOR = 0 unless defined? Snorkeler::Version::MAJOR
    MINOR = 0 unless defined? Snorkeler::Version::MINOR
    PATCH = 1 unless defined? Snorkeler::Version::PATCH
    PRE = nil unless defined? Snorkeler::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
