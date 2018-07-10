# frozen_string_literal: true

require 'service_layer/result'
require 'service_layer/monads/adapter/service_layer_result'

RSpec.describe ServiceLayer::Monads::Adapter::ServiceLayerResult do
  subject(:adapter) { described_class.new(monad) }

  let(:monad) { ServiceLayer::Result.new(attributes) }
  let(:attributes) { { username: 'AdrienSldy', company: 'gemologist' } }

  it { is_expected.to be_success }

  it 'delegates fields getter' do
    is_expected.to respond_to(*attributes.keys).with(0).arguments
  end
end
