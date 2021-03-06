# frozen_string_literal: true

require 'service_layer/monads/factory'

module ServiceLayer
  # @api private
  #
  # +Monads+ encapsulates the monads creation by letting developer choose his
  # favorite dependency. The choice is made through the global configuration of
  # the {ServiceLayer}.
  module Monads
    # The available list of monads dependency.
    FACTORIES = {
      dry:     Factory::Dry.new,
      without: Factory::ServiceLayerResult.new
    }.freeze

    private_constant :FACTORIES

    # Factory for success result.
    #
    # @param value
    # @return [Adapter]
    def self.create_success(value)
      factory.create_success(value)
    end

    # Factory for failure result.
    #
    # @param exception [Exception]
    # @return [Adapter]
    def self.create_failure(exception)
      factory.create_failure(exception)
    end

    private_class_method def self.factory
      if monad == :without
        deprecation_warning *caller[1].match(/^(.+?):(\d+)(?::in `(.*?)')?/)
                                      .captures
      end

      FACTORIES[monad]
    end

    private_class_method def self.deprecation_warning(file, line, method)
      message = <<-DEPRECATE
        DEPRECATION WARNING: You are using deprecated behavior which will be
        removed from the next minor release; use :dry adapter in the config
        instead. (called from #{method} at #{file}:#{line})
      DEPRECATE

      warn message.strip.gsub(/\s+/, ' ')
    end

    private_class_method def self.monad
      ServiceLayer.configuration.monad
    end
  end
end
