# frozen_string_literal: true

require 'dry/monads/result'
require 'service_layer/pipeline/pipe'

module ServiceLayer
  # The +Pipeline+
  module Pipeline
    autoload :Filter, 'service_layer/pipeline/filter'

    def self.included(base)
      base.class_eval do
        include Dry::Monads::Result::Mixin

        define_singleton_method(:filters) { @filters ||= [] }

        ServiceLayer.configuration.filter.each do |method, filter|
          define_singleton_method(method) do |klass, **options|
            filters << { filter: filter, klass: klass, options: options }
          end
        end
      end
    end

    def perform
      properties = {}

      self.class.properties.each_key do |field|
        properties[field] = __send__(field)
      end

      monad = Monads.create_success(**properties)

      self.class.filters.each_with_index do |filter, index|
        properties = monad.value!
        monad = filter[:filter].call(properties, klass: filter[:klass], **filter[:options])

        if monad.failure?
          rollback(self.class.filters[0...index])
          break
        end
      end

      monad
    end

    def rollback(filters: self.class.filters)
      filters.reverse.each do |filter:, klass:, options:|
        filter.rollback(properties, klass: klass, **options)
      end
    end
  end
end
