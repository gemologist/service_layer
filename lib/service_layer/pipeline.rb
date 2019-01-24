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

        ServiceLayer.configuration.filter.each do |key, caller|
          define_singleton_method(key) do |klass, **options|
            filters << { caller: caller, klass: klass, options: options }
          end
        end
      end
    end

    def initialize(filters: self.class.filters)
      @pipe = Pipe.new(filters)
    end

    def call(input)
      @pipe.call(Success(input))
    end
  end
end
