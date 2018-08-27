# frozen_string_literal: true

require 'service_layer/monads/adapter/dry'
require 'service_layer/monads/adapter/service_layer_result'

RSpec.describe ServiceLayer::Monads do
  describe '.create_success' do
    subject(:success) { described_class.create_success(domain: 'gmail.com') }

    context 'without monad' do
      before do
        ServiceLayer.configure { |config| config.monad = :without }
        allow(ServiceLayer::Monads::Adapter::ServiceLayerResult)
          .to receive(:new).and_call_original
      end

      it 'returns a Monads::Adapter::ServiceLayerResult' do
        is_expected.to be_a(ServiceLayer::Monads::Adapter::ServiceLayerResult)
      end

      it 'returns a success monads' do
        is_expected.to be_success
      end

      it 'sets the value to monads' do
        is_expected.to have_attributes(domain: 'gmail.com')
      end

      it 'adapts ServiceLayer::Result' do
        success
        expect(ServiceLayer::Monads::Adapter::ServiceLayerResult)
          .to have_received(:new).with(an_instance_of(ServiceLayer::Result))
      end

      it 'warns a deprecation message' do
        expect { success }.to output(/DEPRECATION WARNING/).to_stderr
      end
    end

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

    context 'without monad' do
      before do
        ServiceLayer.configure { |config| config.monad = :without }
        allow(ServiceLayer::Monads::Adapter::ServiceLayerResult)
          .to receive(:new).and_call_original
      end

      it 'returns a Monads::Adapter::ServiceLayerResult' do
        is_expected.to be_a(ServiceLayer::Monads::Adapter::ServiceLayerResult)
      end

      it 'returns a failure monads' do
        is_expected.to be_failure
      end

      it 'sets the error to monads' do
        expect(failure.error).to be_a StandardError
      end

      it 'adapts ServiceLayer::Result' do
        failure
        expect(ServiceLayer::Monads::Adapter::ServiceLayerResult)
          .to have_received(:new).with(an_instance_of(ServiceLayer::Result))
      end

      it 'warns a deprecation message' do
        expect { failure }.to output(/DEPRECATION WARNING/).to_stderr
      end
    end

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
