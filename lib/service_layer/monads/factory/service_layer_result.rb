# frozen_string_literal: true

require 'service_layer/monads/adapter'

module ServiceLayer
  module Monads
    class Factory
      # +ServiceLayerResult+ is a factory for {Adapter::ServiceLayerResult}.
      class ServiceLayerResult < self
        # (see Monads.create_success)
        def create_success(value)
          require 'service_layer/monads/adapter/service_layer_result'
          require 'service_layer/result'

          Adapter::ServiceLayerResult.new(ServiceLayer::Result.new(value))
        end

        # (see Monads.create_failure)
        def create_failure(exception)
          require 'service_layer/monads/adapter/service_layer_result'
          require 'service_layer/result'

          Adapter::ServiceLayerResult.new(
            ServiceLayer::Result.new(error: exception).tap(&:fail!)
          )
        end
      end
    end
  end
end
