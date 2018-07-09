# frozen_string_literal: true

require 'service_layer/monads/adapter'

module ServiceLayer
  module Monads
    class Adapter
      # +Dry+ is a monad adapter for +Dry::Monads+.
      class Dry < self
        # Delegate monadic methods to the adapted monad.
        def method_missing(method_name, *arguments, &block)
          return super unless @monad.respond_to?(method_name)

          result = @monad.public_send(method_name, *arguments, &block)
          return result unless result.respond_to?(:to_monad)

          self.class.new(result)
        end

        def respond_to_missing?(method_name, include_private = false)
          @monad.respond_to?(method_name) || super
        end

        # @!visibility public
        # @api private
        #
        # {include:Adapter#monad_value}
        private def monad_value
          @monad.value_or
        end

        # @!visibility public
        # @api private
        #
        # {include:Adapter#monad_failure}
        private def monad_failure
          @monad.failure
        end
      end
    end
  end
end
