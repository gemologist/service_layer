# frozen_string_literal: true

RSpec.describe ServiceLayer::Command do
  let(:described_module) { Class.new { include ServiceLayer::Command } }
  let(:command) { described_module.new(email: 'adriensldy@gmail.com') }

  describe '.new' do
    it 'creates properties' do
      expect(command).to respond_to(:email, :email=)
    end

    it 'assigns properties' do
      expect(command).to have_attributes(email: 'adriensldy@gmail.com')
    end
  end

  describe '.perform' do
    before do
      allow(described_module).to receive(:new).and_return(command)
      allow(command).to receive(:execute)
      described_module.perform
    end

    it 'creates an instance' do
      expect(described_module).to have_received(:new).once
    end

    it 'performs #execute' do
      expect(command).to have_received(:execute).once.with(no_args)
    end
  end

  describe '.to_proc' do
    subject { described_module.to_proc }

    it { is_expected.to respond_to(:call) }

    context 'when call the proc' do
      before do
        allow(described_module).to receive(:perform)
        described_module.to_proc.call(email: 'adriensldy@gmail.com')
      end

      it 'calls .perform' do
        expect(described_module)
          .to have_received(:perform).once.with(email: 'adriensldy@gmail.com')
      end
    end
  end

  describe '#execute' do
    subject(:result) { command.execute }

    before do
      allow(command).to receive(:perform).and_return(domain: 'gmail.com')
    end

    it 'performs #perform' do
      result
      expect(command).to have_received(:perform).once.with(no_args)
    end

    it 'returns a Result' do
      is_expected.to be_a(ServiceLayer::Result)
    end

    it 'returns a success Result' do
      is_expected.to be_success
    end

    it 'returns a result containing the return of #perform' do
      is_expected.to have_attributes(domain: 'gmail.com')
    end

    context 'when an exception raises' do
      before { allow(command).to receive(:perform).and_raise TypeError.new }

      it 'returns a failure Result' do
        is_expected.to be_failure
      end

      it 'sets the error to Result' do
        expect(result.error).to be_a TypeError
      end

      context 'with rescued set to this kind of exception' do
        before { described_module.rescued TypeError }

        it 'returns a failure Result' do
          is_expected.to be_failure
        end

        it 'sets the error to Result' do
          expect(result.error).to be_a TypeError
        end
      end

      context 'without rescued set to this kind of exception' do
        before { described_module.rescued ArgumentError }

        it 'raises the exception' do
          expect(&method(:subject)).to raise_error TypeError
        end
      end
    end
  end

  describe '#perform' do
    it 'must implement a perform method' do
      error = NotImplementedError
      message = 'Service must implement a perform method'
      expect { command.perform }.to raise_error error, message
    end
  end
end
