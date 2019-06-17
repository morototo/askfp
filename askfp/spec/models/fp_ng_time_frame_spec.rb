require 'rails_helper'

RSpec.describe FpNgTimeFrame, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:time_frame) }
  end
end
