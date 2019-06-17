class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, foreign_key: "fp_id" , dependent: :destroy
  has_many :reservations, foreign_key: "guest_id" , dependent: :destroy
  has_many :fp_ng_time_frames, dependent: :destroy
  has_one :profile, dependent: :destroy

  scope :fp_user, -> { where(user_type: "fp") }
  scope :guest_user, -> { where(user_type: "guest") }

  after_create :create_profile
  after_create :create_fp_ng_time_frames, if: :is_fp?

  def is_fp?
    self.user_type == "fp"
  end

  def is_guest?
    self.user_type == "guest"
  end

  def create_profile
    Profile.create(user_id: self.id)
  end

  def create_fp_ng_time_frames
    fp_ng_time_frames = []
    TimeFrame.all.each do |time_frame|
      fp_ng_time_frames << FpNgTimeFrame.new(user_id: self.id, time_frame_id: time_frame.id)
    end
    FpNgTimeFrame.import fp_ng_time_frames
  end
end
