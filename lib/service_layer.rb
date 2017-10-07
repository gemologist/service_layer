# frozen_string_literal: true

require 'service_layer/version'

# Service Layer pattern implementation.
#
# Provides an easy way to write services object. They are used to encapsulate
# application logic business.
module ServiceLayer
  autoload :Base, 'service_layer/base'
  autoload :Command, 'service_layer/command'
  autoload :Response, 'service_layer/response'
end
