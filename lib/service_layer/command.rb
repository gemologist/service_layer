# frozen_string_literal: true

module ServiceLayer
  # The +Command+ contains the logic related to the command pattern. This
  # pattern is one of the bases of the service layer. It provides the logic
  # layer abstraction.
  #
  # This is an interface to structure and implement a command object.
  # It imposes the implementation of a perform method and provides a delegation
  # of the execution logic of the command.
  #
  # @example
  #   class PeriodConverter
  #     include ServiceLayer::Command
  #
  #     PERIODS = {
  #       today: ->(today:, **) do
  #         Time.utc(today.year, today.month, today.day)..today
  #       end,
  #       this_week: ->(today:, **) do
  #         date = Date.parse(today.to_s) - today.wday
  #         Time.utc(date.year, date.month, date.day)..today
  #       end,
  #       date_range: ->(date:, **) do
  #         Time.at(date[:start_date])..Time.at(date[:end_date])
  #       end
  #     }
  #
  #     def perform
  #       action = PERIODS.fetch(period.to_sym,
  #                              ->(**) { raise InvalidRange.new(kind) })
  #
  #       range = action.call(
  #         today: Time.now.utc,
  #         date: @date
  #       )
  #
  #       { range: range }
  #     end
  #   end
  #
  #   PeriodConverter.(period: :this_week)
  #   # => #<ServiceLayer::Result:0x00558a4cc55428
  #        @range=2017-10-01 00:00:00 +0200..2017-10-07 12:17:20 +0200,
  #        @success=true>
  module Command
    # @!visibility private
    def self.included(base)
      base.extend ClassMethods
    end

    # @!classmethods
    module ClassMethods
      # @return [Array<Class>] a list of +Exception+.
      def exceptions
        @exceptions ||= []
      end

      # Defines the types of exceptions that must be rescued.
      #
      # @param exceptions [Array<Class>] a list of +Exception+.
      # @return [void]
      def rescued(*exceptions)
        self.exceptions.concat exceptions
      end

      # Invokes a +Command+. This is the primary public API method to a command.
      #
      # Delegates the initialization, and performs the service.
      #
      # @param properties [Hash]
      # @return [Result]
      def perform(**properties)
        new(**properties).execute
      end

      # @!method call(**properties)
      alias call perform

      # Converts the +Command+ to a callable.
      #
      # @return [Proc]
      def to_proc
        ->(**properties) { perform(**properties) }
      end
    end

    # Creates a new object using +Command+ module.
    #
    # Creates and assigns properties dynamically.
    #
    # @param properties [Hash]
    def initialize(**properties)
      singleton_class.class_exec(properties.keys) do |fields|
        attr_accessor(*fields)
      end

      properties.each do |field, value|
        __send__ "#{field}=", value
      end
    end

    # Encapsulates the execution of the service and determines the result state.
    #
    # @return [Monads::Adapter]
    def execute
      Monads.create_success(perform)
    rescue *exceptions => exception
      Monads.create_failure(exception)
    end

    # @abstract must implement perform method when include command pattern.
    # @return [Hash]
    def perform
      raise NotImplementedError.new('Service must implement a perform method')
    end

    private def exceptions
      if self.class.exceptions.empty?
        ServiceLayer.configuration.default_exceptions
      else
        self.class.exceptions
      end
    end
  end
end
