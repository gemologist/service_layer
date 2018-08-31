# frozen_string_literal: true

# Service Layer pattern implementation.
#
# Provide an easy way to write services object. They are used to encapsulate
# application logic business.
module ServiceLayer
  # Maintains all system-wide configuration for +ServiceLayer+.
  class Configuration
    # Defines the default rescued exceptions list.
    #
    # @return [Array<Class>] a list of +Exception+.
    attr_accessor :default_exceptions

    # Defines the monad adapter.
    #
    # @return [Symbol]
    attr_accessor :monad

    def initialize
      @default_exceptions = [StandardError]
      @monad = :without
    end
  end

  private_constant :Configuration
end
