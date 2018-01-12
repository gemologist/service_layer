# frozen_string_literal: true

require 'service_layer/result'

RSpec.describe ServiceLayer::Result do
  it { is_expected.to be_success }
  it { is_expected.not_to be_failure }

  describe '.new' do
    subject { described_class.new attributes }

    let(:attributes) { { username: 'AdrienSldy', company: 'gemologist' } }

    it 'assigns fields' do
      is_expected.to have_attributes(attributes)
    end

    it 'creates fields getter' do
      is_expected.to respond_to(*attributes.keys).with(0).arguments
    end
  end

  describe '#fail!' do
    subject(:result) { described_class.new }

    before { result.fail! }

    it 'changes to be failure' do
      is_expected.to be_failure
    end

    it 'changes not to be success' do
      is_expected.not_to be_success
    end
  end
end
