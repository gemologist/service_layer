# frozen_string_literal: true

require 'service_layer/version'

# Provides an easy way to write objects responsible for encapsulating domain
# layer.
module ServiceLayer
  autoload :Base, 'service_layer/base'
  autoload :Command, 'service_layer/command'
  autoload :Response, 'service_layer/response'
end
