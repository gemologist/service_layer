# frozen_string_literal: true

require 'dry/monads/result'

module ServiceLayer
  module Pipeline
    class Filter
      # The +Compose+
      class Compose
        include Dry::Monads::Result::Mixin

        def call(input, klass:, **args, &block)
          klass.perform(input)
        end

        def rollback(input, klass:, **args, &block)
          klass.new.rollback(input)
        end
      end

      # @!method
      register :compose, Compose.new
    end
  end
end
