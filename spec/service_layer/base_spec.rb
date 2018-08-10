# frozen_string_literal: true

RSpec.describe ServiceLayer::Base do
  let(:service) { described_class.new }

  describe '#execute' do
    let(:result) { service.execute }

    before do
      allow(described_class).to receive(:new).and_return(service)
      described_class.render :domain
      allow(service).to receive(:perform)
      service.domain = 'gmail.com'
    end

    it 'performs #perform' do
      result
      expect(service).to have_received(:perform).once.with(no_args)
    end

    it 'returns a Monads::Adapter' do
      expect(result).to be_a(ServiceLayer::Monads::Adapter)
    end

    it 'returns a success monads' do
      expect(result).to be_success
    end

    it 'returns a monads containing the rendering attributes' do
      expect(result).to have_attributes(domain: 'gmail.com')
    end

    context 'when an exception raises' do
      before do
        allow(service).to receive(:perform).and_raise
      end

      it 'returns a failure monads' do
        expect(result).to be_failure
      end

      it 'sets the error to monads' do
        expect(result.error).to be_a StandardError
      end
    end
  end
end
