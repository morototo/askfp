class Reservation < ApplicationRecord
  belongs_to :fp, class_name: 'User', foreign_key: 'fp_id'
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'

  validates :fp_id, presence: true
  validates :guest_id, presence: true
  validates :start_at, presence: true
  validates :reservation_date, presence: true

  after_create :set_end_at

  def set_end_at
    frame_min  = (60 * 30)
    self.end_at = (Time.parse(self.start_at) + frame_min).strftime("%H:%M")
    save!
  end
end
