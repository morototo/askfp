class Reservation < ApplicationRecord
  belongs_to :fp, class_name: 'User', foreign_key: 'fp_id'
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'

  validates :fp_id, presence: true
  validates :guest_id, presence: true
  validates :start_at, presence: true
  validates :reservation_date, presence: true
end
