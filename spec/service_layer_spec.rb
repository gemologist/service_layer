# frozen_string_literal: true

RSpec.describe ServiceLayer do
  describe '.configuration' do
    subject { described_class.configuration }

    it { is_expected.to be_a(described_class.const_get(:Configuration)) }

    it 'memoizes the Configuration' do
      is_expected.to equal(described_class.configuration)
    end
  end

  describe '.configure' do
    it do
      expect { |config| described_class.configure(&config) }
        .to yield_with_args(described_class.configuration)
    end
  end
end
