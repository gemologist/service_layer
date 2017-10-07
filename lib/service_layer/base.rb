# frozen_string_literal: true

module ServiceLayer
  # The +Base+ contains all related logic of service layer pattern.
  #
  # @abstract Inherit to make your class a service.
  #   To implement a service, override {#perform}.
  #
  # @example
  #   class Dispatcher < ServiceLayer::Base
  #     DOMAINS = {
  #       gmail: Gmail.new,
  #       outlook: Outlook.new,
  #       yahoo: Yahoo.new
  #     }.freeze
  #
  #     def perform
  #       domains_contacts = contacts.domain_batches
  #       domains_contacts.each do |domain, domain_contacts|
  #         domain_contacts.find_in_batches(of: fetch_domain(domain).size)
  #                        .with_index do |batch_contacts, batch_index|
  #           wait = fetch_domain(domain).time * batch_index
  #           MarketingMailer.perform(email, batch_contacts)
  #                          .deliver_later(wait: wait)
  #         end
  #       end
  #
  #       Success.new(data: domains_contacts)
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
  #   # => #<ServiceLayer::Response::Success:0x007fe46104f798
  #        @data={:gmail=>[...], :outlook=>[...]}, @message=nil>
  class Base
    include Command
    include Response
  end
end
