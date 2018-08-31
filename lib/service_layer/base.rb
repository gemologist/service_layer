# frozen_string_literal: true

module ServiceLayer
  # The +Base+ contains all related logic of service layer pattern.
  #
  # @abstract Inherit to make your class a service.
  #   To implement a service, override {#perform}.
  #
  # You can declare the contract of your service. It allows to define the input
  # attribute and the output attribute.
  #
  # The call of a service returns a {Monads::Adapter}, allowing to know the
  # success of this execution.
  #
  # @example
  #   class Dispatcher < ServiceLayer::Base
  #     DOMAINS = {
  #       gmail: Gmail.new,
  #       outlook: Outlook.new,
  #       yahoo: Yahoo.new
  #     }.freeze
  #
  #     property :email, :contacts
  #
  #     def perform
  #       contacts.domain_batches.each do |domain, domain_contacts|
  #         domain_contacts.find_in_batches(of: fetch_domain(domain).size)
  #                        .with_index do |batch_contacts, batch_index|
  #           wait = fetch_domain(domain).time * batch_index
  #           MarketingMailer.perform(email, batch_contacts)
  #                          .deliver_later(wait: wait)
  #         end
  #       end
  #     end
  #
  #     private
  #
  #     def fetch_domain(domain)
  #       DOMAINS.fetch(domain, Domain.new)
  #     end
  #   end
  #
  #   Dispatcher.perform(email: Email.find(34), contacts: Contact.all)
  #   # => #<ServiceLayer::Result:0x007f8e5c12cf90 @success=true>
  class Base
    include Command
    include Contract

    # Overrides the command mechanism execution. Provides the rendering keys by
    # following the contract pattern.
    #
    # @return [Monads::Adapter]
    def execute
      perform
    rescue *exceptions => exception
      Monads.create_failure(exception)
    else
      render
    end
  end
end
