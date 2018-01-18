# frozen_string_literal: true

module ServiceLayer
  # The +Contract+ makes it possible to structure an object.
  #
  # Allows you to set all the properties by passing in a hash of attributes with
  # keys matching the fields defined with {.property}.
  #
  # @example
  #   class Account
  #     include ServiceLayer::Contract
  #
  #     property :email
  #   end
  #
  #   Account.new(email: 'adriensldy@gmail.com')
  #   # => #<Account:0x007f93a4837568 @email="adriensldy@gmail.com">
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

      # Defines all property fields who will be auto-assign.
      #
      # @param fields [Array<String, Symbol>]
      # @return [void]
      def property(*fields)
        attr_accessor(*fields)
        properties.concat fields
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
  end
end
