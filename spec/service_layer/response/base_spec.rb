# frozen_string_literal: true

RSpec.describe ServiceLayer::Response::Base do
  subject(:response) { described_class.new }

  describe '#success?' do
    it { expect { response.success? }.to raise_error NotImplementedError }
  end
end
