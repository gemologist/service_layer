# frozen_string_literal: true

module ServiceLayer
  module Response
    # Represents a value of a failed operation.
    class Error < Base
      def success?
        false
      end
    end
  end
end
