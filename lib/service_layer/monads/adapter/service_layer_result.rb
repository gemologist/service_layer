# frozen_string_literal: true

require 'service_layer/monads/adapter'

module ServiceLayer
  module Monads
    class Adapter
      # +ServiceLayerResult+ is a monad adapter for {Result}.
      class ServiceLayerResult < self
        # Delegate result accessors to the adapted result.
        def method_missing(method_name, *arguments, &block)
          return super unless @monad.respond_to?(method_name)

          @monad.public_send(method_name, *arguments, &block)
        end

        def respond_to_missing?(method_name, include_private = false)
          @monad.respond_to?(method_name) || super
        end

        private

        def monad_value; end

        # @!visibility public
        # @api private
        #
        # {include:Adapter#monad_failure}
        def monad_failure
          @monad.error
        end
      end
    end
  end
end
