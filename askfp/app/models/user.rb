class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, foreign_key: "fp_id" , dependent: :destroy
  has_many :reservations, foreign_key: "guest_id" , dependent: :destroy
  has_one :profile, dependent: :destroy

  scope :fp_user, -> { where(user_type: "fp") }
  scope :guest_user, -> { where(user_type: "guest") }

  after_create :create_profile

  def is_fp?
    self.user_type == "fp"
  end

  def is_guest?
    self.user_type == "guest"
  end

  def create_profile
    Profile.create(user_id: self.id)
  end
end
