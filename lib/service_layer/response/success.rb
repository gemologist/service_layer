# frozen_string_literal: true

module ServiceLayer
  module Response
    # Represents a value of a successful operation.
    class Success < Base
      def success?
        true
      end
    end
  end
end
