# frozen_string_literal: true

module ServiceLayer
  module Pipeline
    # The +Pipe+
    class Pipe
      def initialize(filters)
        @filters = filters
      end

      def call(monad)
        previous = monad

        @filters.each do |caller:, klass:, options:|
          data = monad.value!.merge!(previous.value!)
          previous = caller.call(data, klass: klass, **options)

          # return previous if previous.failure?
        end

        monad
      end
    end
  end
end
