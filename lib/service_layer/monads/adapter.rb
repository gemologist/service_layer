# frozen_string_literal: true

module ServiceLayer
  module Monads
    # @api public
    #
    # This is a base class for all Service Layer Monads adapters.
    #
    # @abstract Override this class to implement a monadic adapter.
    #
    # Provides a unique interface for supporting all different monadic
    # implementations.
    #
    # Adapters are responsible for delegating all monadic methods to the
    # appropriate monad.
    class Adapter
      # Creates a new monad adapter.
      #
      # @param monad the adapted monad.
      # @see #getters!
      def initialize(monad)
        @monad = monad

        getters!
      end

      # Indicates whether the monad is successful.
      #
      # @return [Boolean]
      def success?
        @monad.success?
      end

      # Indicates whether the monad is failed.
      #
      # @return [Boolean]
      def failure?
        !success?
      end

      # Returns the monadic failure.
      #
      # Public API to get the rescued exception.
      #
      # @see #monad_failure
      def error
        monad_failure
      end

      alias exception error

      private

      # @!visibility public
      # @api private
      #
      # Creates getter for the monad value keys.
      #
      # @return [void]
      # @see #monad_value
      def getters!
        return unless monad_value.respond_to? :each_key

        monad_value.each_key do |field|
          next if respond_to?(field)

          define_singleton_method(field) { monad_value[field] }
        end
      end

      # @!visibility public
      # @api private
      #
      # Returns the monadic value.
      #
      # @abstract This method should return the wrapped value.
      def monad_value
        raise NotImplementedError.new(
                'Monads::Adapter must implement a monad_value method'
              )
      end

      # @!visibility public
      # @api private
      #
      # Returns the monadic failure.
      #
      # @abstract This method should return the wrapped failure.
      def monad_failure
        raise NotImplementedError.new(
                'Monads::Adapter must implement a monad_failure method'
              )
      end
    end
  end
end
