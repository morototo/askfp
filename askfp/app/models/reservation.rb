class Reservation < ApplicationRecord
  belongs_to :fp, class_name: 'User', foreign_key: 'fp_id'
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'

  validates :fp_id, presence: true
  validates :guest_id, presence: true
  validates :start_at, presence: true
  validates :reservation_date, presence: true

  scope :reserved, -> fp_id { where(fp_id: fp_id) }
  scope :target_date, -> target_date { where(reservation_date: target_date) }

  after_create :set_end_at

  def self.get_free_reservation_time(time, fp_id, target_date)
    except_reservation_time = []
    reserved_times     = Reservation.target_date(target_date).reserved(fp_id).pluck(:start_at)
    cant_reserve_times = target_date.saturday? ? FpNgTimeFrame.mine(fp_id).only_holiday.joins(:time_frame).pluck(:start_at) : 
                                                    FpNgTimeFrame.mine(fp_id).only_weekday.joins(:time_frame).pluck(:start_at)
    time.each do |t|
      next if reserved_times.include?(t[0]) || cant_reserve_times.include?(t[0])
      except_reservation_time << t
    end
    except_reservation_time.uniq
  end

  def set_end_at
    frame_min  = (60 * 30)
    self.end_at = (Time.parse(self.start_at) + frame_min).strftime("%H:%M")
    save!
  end
end
