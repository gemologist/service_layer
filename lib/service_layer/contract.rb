# frozen_string_literal: true

require 'service_layer/result'
require 'service_layer/contract/value'

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
  #     property! :email
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
      # @return [Hash]
      def properties
        @properties ||= {}
      end

      # @return [Array<String, Symbol>]
      def render_fields
        @render_fields ||= []
      end

      # Defines all property fields who will be auto-assign.
      #
      # @param fields [Array<String, Symbol>]
      # @param properties [Hash] field => default_value
      # @return [void]
      def property(*fields, **properties)
        fields!(*(fields + properties.keys))

        properties!(*fields).merge!(properties)
      end

      # Defines all required property fields who will be auto-assign.
      #
      # @param fields [Array<String, Symbol>]
      # @return [void]
      def property!(*fields)
        fields!(*fields)

        default_value = ->(property) do
          raise ArgumentError.new("The :#{property} property is missing")
        end
        properties!(*fields, &default_value)
      end

      private def properties!(*fields, &default_value)
        properties.merge! Hash[fields.map { |field| [field, default_value] }]
      end

      private def fields!(*fields)
        attr_accessor(*fields)
        private(*(fields + fields.map { |field| :"#{field}=" }))
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
    # Sets properties defined with {.property!} and {.property}.
    #
    # @param attributes [Hash]
    # @raise [ArgumentError] when a required property is missing.
    def initialize(**attributes)
      self.class.properties.each do |property, default_value|
        default = Value.new(default_value).to_proc
        __send__ "#{property}=", attributes.fetch(property, &default)
      end
    end

    private def assign_properties(properties, **attributes)
      properties.each do |property|
        value = attributes[property]
        yield property, value if block_given?
        __send__ "#{property}=", value
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
