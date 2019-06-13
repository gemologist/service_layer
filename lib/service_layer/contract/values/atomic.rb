# frozen_string_literal: true

module ServiceLayer
  module Contract
    module Values
      class Atomic
        def initialize(value)
          @value = value
        end

        def to_proc
          Proc.new { @value }
        end
      end

      private_constant :Atomic
    end
  end
end
