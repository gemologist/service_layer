# frozen_string_literal: true

require 'ostruct'

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
  #         date: context[:date]
  #       )
  #
  #       { range: range }
  #     end
  #   end
  #
  #   PeriodConverter.perform(period: :this_week)
  #   # => {:range=>2017-10-01 00:00:00 +0200..2017-10-07 12:17:20 +0200}
  module Command
    # @!visibility private
    def self.included(base)
      base.class_eval do
        extend ClassMethods

        attr_reader :context
      end
    end

    # @!classmethods
    module ClassMethods
      # Invokes a +Command+. This is the primary public API method to a command.
      #
      # Delegates the initialization, and performs the service.
      #
      # @param context [Hash]
      def perform(**context)
        new(**context).perform
      end
    end

    # Creates a new object using +Command+ module.
    #
    # @param context [Hash]
    def initialize(**context)
      @context = OpenStruct.new(context)
      context_reader
    end

    # @abstract must implement perform method when include command pattern.
    def perform
      raise NotImplementedError.new('Service must implement a perform method')
    end

    private

    def context_reader
      context.to_h.each_key do |key|
        define_singleton_method(key) { context[key] }
        define_singleton_method("#{key}=") { |value| context[key] = value }
      end
    end
  end
end
