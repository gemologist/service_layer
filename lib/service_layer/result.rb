# frozen_string_literal: true

module ServiceLayer
  # @deprecated Use {https://github.com/dry-rb/dry-monads dry-monads} instead.
  #   Configure {ServiceLayer} to use {Monads::Adapter::Dry it}.
  #     ServiceLayer.configure do |config|
  #       config.monad = :dry
  #     end
  #
  # The +Result+ formats the return of complex logics.
  #
  # Knows the execution status, success or failure. Access fields by using
  # getter methods.
  #
  # @example
  #   result = ServiceLayer::Result.new(username: 'AdrienSldy',
  #                                     company: 'gemologist')
  #   result.username
  #   # => "AdrienSldy"
  #   result.company
  #   # => "gemologist"
  #   result.success?
  #   # => true
  #   result.fail!
  #   result.success?
  #   # => false
  class Result
    # Creates a new +Result+ object.
    #
    # Creates getters and assigns fields dynamically.
    #
    # @param attributes [Hash]
    def initialize(**attributes)
      singleton_class.class_exec(attributes.keys) do |fields|
        attr_reader(*fields)
      end

      attributes.each do |field, value|
        instance_variable_set "@#{field}", value
      end

      @success = true
    end

    # Indicates whether the +Result+ is successful.
    #
    # @return [Boolean]
    # @note By default, a new result is successful and only changes when
    # explicitly failed.
    # @see #fail!
    def success?
      @success
    end

    # Indicates whether the +Result+ is failed.
    #
    # @return [Boolean]
    # @note By default, a new result is successful and only changes when
    # explicitly failed.
    # @see #fail!
    def failure?
      !success?
    end

    # Change the +Result+ success to a failure.
    #
    # @return [void]
    def fail!
      @success = false
    end
  end
end
