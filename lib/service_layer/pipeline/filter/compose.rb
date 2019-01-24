# frozen_string_literal: true

require 'dry/monads/result'

module ServiceLayer
  module Pipeline
    class Filter
      # The +Compose+
      class Compose
        include Dry::Monads::Result::Mixin

        def call(input, klass:, **args, &block)
          binding.irb

          result = klass.call(input)


        #   block ||= ->(data) { data || {} }
        #
        #   entity = klass.new
        #
        #   result = entity.call(args.merge(block.call(input)))
        #
        #   if entity.success?
        #     result
        #   else
        #     entity.rollback(result)
        #   end
        # rescue StandardError => error
        #   entity.rollback(args.merge(block.call(input)))
        #   Failure(error)
        end
      end

      # @!method
      register :compose, Compose.new
    end
  end
end
