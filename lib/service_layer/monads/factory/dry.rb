# frozen_string_literal: true

module ServiceLayer
  module Monads
    class Factory
      # +Dry+ is a factory for {Adapter::Dry}.
      class Dry < self
        # (see Monads.create_success)
        def create_success(value)
          require 'service_layer/monads/adapter/dry'
          require 'dry/monads/result'

          Adapter::Dry.new(::Dry::Monads::Success(value))
        end

        # (see Monads.create_failure)
        def create_failure(exception)
          require 'service_layer/monads/adapter/dry'
          require 'dry/monads/result'

          Adapter::Dry.new(::Dry::Monads::Failure(exception))
        end
      end
    end
  end
end
