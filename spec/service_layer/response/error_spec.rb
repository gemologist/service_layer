# frozen_string_literal: true

RSpec.describe ServiceLayer::Response::Error do
  describe '#success?' do
    it { is_expected.not_to be_success }
  end
end
