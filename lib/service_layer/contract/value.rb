# frozen_string_literal: true

require 'service_layer/contract/values/atomic'
require 'service_layer/contract/values/closure'

module ServiceLayer
  module Contract
    class Value
      CONVERTERS = {
        true  => Values::Closure,
        false => Values::Atomic
      }.freeze

      def initialize(value, converters: CONVERTERS)
        @value, @converters = value, converters
      end

      def to_proc
        @converters[@value.respond_to?(:to_proc)].new(@value).to_proc
      end
    end

    private_constant :Value
  end
end
