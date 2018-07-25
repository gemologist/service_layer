# frozen_string_literal: true

require 'service_layer/version'
require 'service_layer/configuration'

# Service Layer pattern implementation.
#
# Provides an easy way to write services object. They are used to encapsulate
# application logic business.
module ServiceLayer
  autoload :Base, 'service_layer/base'
  autoload :Command, 'service_layer/command'
  autoload :Contract, 'service_layer/contract'
  autoload :Monads, 'service_layer/monads'

  # Configures +ServiceLayer+ settings.
  #
  # @yield [config] to set +ServiceLayer+ settings.
  # @example
  #   ServiceLayer.configure do |config|
  #     config.monad = :dry
  #   end
  def self.configure
    yield configuration
  end

  # @return [Configuration]
  def self.configuration
    @configuration ||= Configuration.new
  end
end
