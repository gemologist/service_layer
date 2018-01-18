# frozen_string_literal: true

RSpec.describe ServiceLayer::Contract do
  let(:described_module) { Class.new.__send__(:include, described_class) }

  describe '.property' do
    subject { described_module.new(properties) }

    let(:properties) { { email: 'adriensldy@gmail.com' } }

    before { described_module.property :email }

    it 'creates properties' do
      is_expected.to respond_to(:email, :email=)
    end

    it 'assigns properties' do
      is_expected.to have_attributes(properties)
    end
  end
end
