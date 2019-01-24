# frozen_string_literal: true

require 'service_layer/monads/adapter/dry'

RSpec.describe ServiceLayer::Monads do
  describe '.create_success' do
    subject(:success) { described_class.create_success(domain: 'gmail.com') }

    context 'with monad :dry' do
      before do
        ServiceLayer.configure { |config| config.monad = :dry }
        allow(ServiceLayer::Monads::Adapter::Dry)
          .to receive(:new).and_call_original
        success
      end

      it 'returns a Monads::Adapter::Dry' do
        is_expected.to be_a(ServiceLayer::Monads::Adapter::Dry)
      end

      it 'adapts Dry::Monads::Result::Success' do
        expect(ServiceLayer::Monads::Adapter::Dry).to(
          have_received(:new).with(an_instance_of(Dry::Monads::Result::Success))
        )
      end
    end
  end

  describe '.create_failure' do
    subject(:failure) { described_class.create_failure(StandardError.new) }

    context 'with monad :dry' do
      before do
        ServiceLayer.configure { |config| config.monad = :dry }
        allow(ServiceLayer::Monads::Adapter::Dry)
          .to receive(:new).and_call_original
        failure
      end

      it 'returns a Monads::Adapter::Dry' do
        is_expected.to be_a(ServiceLayer::Monads::Adapter::Dry)
      end

      it 'adapts Dry::Monads::Result::Failure' do
        expect(ServiceLayer::Monads::Adapter::Dry).to(
          have_received(:new).with(an_instance_of(Dry::Monads::Result::Failure))
        )
      end
    end
  end
end
