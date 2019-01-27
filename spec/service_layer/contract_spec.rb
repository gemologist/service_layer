# frozen_string_literal: true

RSpec.describe ServiceLayer::Contract do
  let(:described_module) { Class.new.__send__(:include, described_class) }
  let(:email_value) { 'adriensldy@gmail.com' }
  let(:properties) { { email: email_value } }

  describe '.property' do
    subject(:contract) { described_module.new(properties) }

    before { described_module.property :email }

    it 'creates properties' do
      expect(contract.respond_to? :email, true).to be true
      expect(contract.respond_to? :email=, true).to be true
    end

    it 'assigns properties' do
      expect(contract.__send__(:email)).to be(email_value)
    end

    context 'when a property is missing' do
      subject(:contract) { described_module.new }

      context 'without default value' do
        it 'assigns properties to `nil`' do
          expect(contract.__send__(:email)).to be(nil)
        end
      end
<<<<<<< HEAD

      context 'with default value' do
        subject { described_module.new }

        before { described_module.property email: 'adriensldy@gmail.com' }

        it 'fallbacks to the default defined' do
          is_expected.to have_attributes(properties)
=======

      context 'with default value' do
        before { described_module.property email: email_value }

        it 'fallbacks to the default defined' do
          expect(contract.__send__(:email)).to be(email_value)
>>>>>>> Fix some rspec error
        end
      end

      context 'with default block value' do
<<<<<<< HEAD
        subject { described_module.new }

        before { described_module.property email: -> { 'adriensldy@gmail.com' } }

        it 'fallbacks to the output of the default defined block' do
          is_expected.to have_attributes(properties)
=======
        subject(:contract) { described_module.new }

        before { described_module.property email: -> { email_value } }

        it 'fallbacks to the output of the default defined block' do
          expect(contract.__send__(:email)).to be(email_value)
>>>>>>> Fix some rspec error
        end
      end
    end
  end

  describe '.property!' do
    subject(:contract) { described_module.new(properties) }

    before { described_module.property! :email }
gst
    it 'creates properties' do
      expect(contract.respond_to? :email, true).to be true
      expect(contract.respond_to? :email=, true).to be true
    end

    it 'assigns properties' do
      expect(contract.__send__(:email)).to be(email_value)
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

    it 'returns a Monads::Adapter' do
      is_expected.to be_a(ServiceLayer::Monads::Adapter)
    end

    it 'returns a monads containing the rendering attributes' do
      contract.domain = 'gmail.com'
      is_expected.to have_attributes(domain: 'gmail.com')
    end
  end
end
