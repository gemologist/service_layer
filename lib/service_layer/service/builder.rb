require 'dry/monads/result'
require 'orchestrator/service/dsl'
require 'orchestrator/service/methods'

module Orchestrator
  module Service
    module Builder
      def self.included(base)
        base.class_eval do
          include Dry::Monads::Result::Mixin

          define_singleton_method(:context) { @context ||= [] }

          define_singleton_method(:attribute) do |attribute, **options|
            context << { name: attribute, options: options }
          end
        end
      end

      def initialize(context: self.class.context)
        @context = context.map { |param| param[:name] }

        freeze
      end

      def call(input)
        data = input.select { |k, _| @context.include?(k) }
        perform(data)
      end

      def rollback(_failure)
        # no-op
      end
    end
  end
end
