# frozen_string_literal: true

RSpec.describe ServiceLayer::Response::Success do
  describe '#success?' do
    it { is_expected.to be_success }
  end
end
