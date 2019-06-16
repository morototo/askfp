require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:fp).class_name('User') }
    it { should belong_to(:guest).class_name('User') }
  end
end
