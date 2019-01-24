require 'orchestrator/version'
require 'orchestrator/builder'
require 'orchestrator/service/builder'

module Orchestrator
  def self.composer(adapters: Orchestrator::StepAdapters)
    Builder.new(adapters: adapters)
  end

  def self.layer
    Service::Builder
  end
end
