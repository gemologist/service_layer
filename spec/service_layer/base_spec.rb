# frozen_string_literal: true

RSpec.describe ServiceLayer::Base do
  let(:service) { described_class.new }

  describe '#execute' do
    subject(:result) { service.execute }

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

    it 'returns a Result' do
      expect(result).to be_a(ServiceLayer::Result)
    end

    it 'returns a success Result' do
      expect(result).to be_success
    end

    it 'returns a Result containing the rendering attributes' do
      expect(result).to have_attributes(domain: 'gmail.com')
    end

    context 'when an exception raises' do
      before { allow(service).to receive(:perform).and_raise TypeError.new }
      after { described_class.exceptions.clear }

      it 'returns a failure Result' do
        is_expected.to be_failure
      end

      it 'sets the error to Result' do
        expect(result.error).to be_a TypeError
      end

      context 'with rescued set to this kind of exception' do
        before { described_class.rescued TypeError }

        it 'returns a failure Result' do
          is_expected.to be_failure
        end

        it 'sets the error to Result' do
          expect(result.error).to be_a TypeError
        end
      end

      context 'without rescued set to this kind of exception' do
        before { described_class.rescued ArgumentError }

        it 'raises the exception' do
          expect(&method(:subject)).to raise_error TypeError
        end
      end
    end
  end
end
