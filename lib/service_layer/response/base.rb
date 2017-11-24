# frozen_string_literal: true

module ServiceLayer
  module Response
    # Represents an abstract response implementation which either succeeded or
    # failed.
    class Base
      attr_reader :data, :message

      def initialize(data: nil, message: nil)
        @data = data
        @message = message
      end

      def success?
        raise NotImplementedError
      end

      def failure?
        !success?
      end
    end
  end
end
