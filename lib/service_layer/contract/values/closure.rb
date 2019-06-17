# frozen_string_literal: true

module ServiceLayer
  module Contract
    module Values
      class Closure
        def initialize(value)
          @value = value.to_proc
        end

        def to_proc
          [Proc.new { @value.call }].fetch(@value.arity, @value)
        end
      end
    end
  end
end
