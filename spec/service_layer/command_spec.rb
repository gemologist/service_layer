# frozen_string_literal: true

RSpec.describe ServiceLayer::Command do
  let(:described_module) { Class.new.__send__(:include, described_class) }

  describe '.new' do
    let(:command) { described_module.new(email: 'adriensldy@gmail.com') }

    it 'creates accessor for each key' do
      expect(command).to respond_to(:email, :email=)
    end
  end

  describe '.perform' do
    let!(:command) { instance_spy(described_module) }

    before do
      allow(described_module).to receive(:new).and_return(command)
      described_module.perform
    end

    it 'creates an instance' do
      expect(described_module).to have_received(:new).once
    end

    it 'performs #perform' do
      expect(command).to have_received(:perform).once.with(no_args)
    end
  end

  describe '#perform' do
    it 'must implement a perform method' do
      error = NotImplementedError
      message = 'Service must implement a perform method'
      expect { described_module.new.perform }.to raise_error error, message
    end
  end
end
