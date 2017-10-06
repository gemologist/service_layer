# frozen_string_literal: true

module ServiceLayer
  # The +Base+ contains all related logic of service layer pattern.
  #
  # @abstract Inherit to make your class a service.
  class Base
    include Response
  end
end
