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

    context 'when a property is missing' do
      context 'without default value' do
        subject { described_module.new }

        it 'assigns properties to `nil`' do
          is_expected.to have_attributes(email: nil)
        end
      end

      context 'with default value' do
        subject { described_module.new }

        before { described_module.property email: 'adriensldy@gmail.com' }

        it 'fallbacks to the default defined' do
          is_expected.to have_attributes(properties)
        end
      end

      context 'with default block value' do
        subject { described_module.new }

        before { described_module.property email: -> { 'adriensldy@gmail.com' } }

        it 'fallbacks to the output of the default defined block' do
          is_expected.to have_attributes(properties)
        end
      end
    end
  end

  describe '.property!' do
    subject { described_module.new(properties) }

    let(:properties) { { email: 'adriensldy@gmail.com' } }

    before { described_module.property! :email }

    it 'creates properties' do
      is_expected.to respond_to(:email, :email=)
    end

    it 'assigns properties' do
      is_expected.to have_attributes(properties)
    end

    context 'when a property is missing' do
      before { described_module.property! :first_name }

      it 'raises ArgumentError with "The :first_name property is missing"' do
        message = 'The :first_name property is missing'
        expect(&method(:subject)).to raise_error(ArgumentError, message)
      end
    end
  end

  describe '#render' do
    subject { contract.render }

    let(:contract) { described_module.new }

    before { described_module.render :domain }

    it 'returns a Result' do
      is_expected.to be_a(ServiceLayer::Result)
    end

    it 'returns a Result containing the rendering attributes' do
      contract.domain = 'gmail.com'
      is_expected.to have_attributes(domain: 'gmail.com')
    end
  end
end
