# frozen_string_literal: true

require 'service_layer/result'

module ServiceLayer
  # The +Contract+ makes it possible to structure an object.
  #
  # Allows you to set all the properties by passing in a hash of attributes with
  # keys matching the fields defined with {.property}.
  #
  # Renders a {Result} with {#render} containing the fields defined with
  # {.render}.
  #
  # @example
  #   class Account
  #     include ServiceLayer::Contract
  #
  #     property :email
  #     render :domain
  #
  #     def domain!
  #       domain ||= email.split('@').last
  #     end
  #   end
  #
  #   account = Account.new(email: 'adriensldy@gmail.com')
  #   # => #<Account:0x007f93a4837568 @email="adriensldy@gmail.com">
  #   account.domain!
  #   account.render
  #   # => #<ServiceLayer::Result:0x007fb04f118df0 @domain="gmail.com",
  #        @success=true>
  module Contract
    # @!visibility private
    def self.included(base)
      base.extend ClassMethods
    end

    # @!classmethods
    module ClassMethods
      # @return [Array<String, Symbol>]
      def properties
        @properties ||= []
      end

      # @return [Array<String, Symbol>]
      def render_fields
        @render_fields ||= []
      end

      # Defines all property fields who will be auto-assign.
      #
      # @param fields [Array<String, Symbol>]
      # @return [void]
      def property(*fields)
        attr_accessor(*fields)
        properties.concat fields
      end

      # Defines all fields who will be render.
      #
      # @param fields [Array<String, Symbol>] the render fields.
      # @return [void]
      def render(*fields)
        attr_accessor(*fields)
        render_fields.concat fields
      end
    end

    # Creates a new object using +Contract+ module.
    #
    # Sets properties defined with {.property}.
    #
    # @param attributes [Hash]
    def initialize(**attributes)
      self.class.properties.each do |property|
        __send__ "#{property}=", attributes.delete(property)
      end
    end

    # Renders the contract.
    #
    # @return [Result] contains the render fields defined with {.render}.
    def render
      render_fields = {}
      self.class.render_fields.each do |field|
        render_fields[field] = __send__(field)
      end

      Result.new(**render_fields)
    end
  end
end
