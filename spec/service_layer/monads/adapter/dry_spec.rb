# frozen_string_literal: true

require 'dry/monads/result'
require 'service_layer/monads/adapter/dry'

RSpec.describe ServiceLayer::Monads::Adapter::Dry do
  subject(:adapter) { described_class.new(monad) }

  let(:monad) do
    instance_spy(Dry::Monads::Success,
                 value!:   { email: 'adriensldy@gmail.com' },
                 value_or: { email: 'adriensldy@gmail.com' })
  end

  it 'delegates monadic methods' do
    adapter.bind { |email:| email.split('@').last }
    expect(monad).to have_received(:bind)
  end

  it 'creates getters' do
    is_expected.to respond_to(:email).with(0).arguments
  end
end
