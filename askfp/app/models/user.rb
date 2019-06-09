class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservation, dependent: :destroy

  scope :fp_user, -> { where(user_type: "fp") }
  scope :guest_user, -> { where(user_type: "guest") }

  def is_fp?
    self.user_type == "fp"
  end

  def is_guest?
    self.user_type == "guest"
  end
end
