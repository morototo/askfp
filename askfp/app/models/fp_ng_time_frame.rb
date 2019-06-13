class FpNgTimeFrame < ApplicationRecord
  belongs_to :user
  belongs_to :time_frame

  scope :mine, -> user_id{ where(user_id: user_id) }
end
