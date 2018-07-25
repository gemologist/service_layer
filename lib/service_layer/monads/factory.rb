# frozen_string_literal: true

module ServiceLayer
  # @api private
  #
  # +Monads+ encapsulates the monads creation by letting developer choose his
  # favorite dependency. The choice is made through the global configuration of
  # the {ServiceLayer}.
  module Monads
    # @abstract
    #
    # This is a base class for all Service Layer Monads factories.
    #
    # Provides a unique interface for construct the monadic adapters.
    class Factory
      # @abstract
      # @param _value
      # @return [Adapter]
      def create_success(_value)
        raise NotImplementedError.new(
                'Monads::Factory must implement a create_success method'
              )
      end

      # @abstract
      # @param _exception [Exception]
      # @return [Adapter]
      def create_failure(_exception)
        raise NotImplementedError.new(
                'Monads::Factory must implement a create_failure method'
              )
      end
    end

    private_constant :Factory
  end
end

Dir.glob(File.join(__dir__, 'factory', '*.rb'), &method(:require))
