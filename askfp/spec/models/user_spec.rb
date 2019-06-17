require 'rails_helper'

RSpec.describe User, type: :model do
  let(:fp) { FactoryBot.create(:user, :fp) }
  let(:guest) { FactoryBot.create(:user, :guest) }

  describe 'associations' do
    it "FPユーザの場合: has_one: Profile" do
      expect(fp).to have_one(:profile)
    end

    it "FPユーザの場合: has_many: FpNgTimeFrame" do
      expect(fp).to have_many(:fp_ng_time_frames)
    end

    it "FPユーザの場合: has_many: Reservation" do
      expect(fp).to have_many(:reservations)
    end

    it "ゲストユーザの場合: has_one: Profile" do
      expect(guest).to have_one(:profile)
    end

    it "ゲストユーザの場合: has_many: Reservation" do
      expect(guest).to have_many(:reservations)
    end
  end
end
