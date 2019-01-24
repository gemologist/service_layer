# frozen_string_literal: true

require 'dry-container'

module ServiceLayer
  module Pipeline
    # The +Filter+
    class Filter
      extend Dry::Container::Mixin
    end
  end
end

require 'service_layer/pipeline/filter/compose'
