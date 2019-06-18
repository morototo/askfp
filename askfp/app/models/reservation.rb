class Reservation < ApplicationRecord
  belongs_to :fp, class_name: 'User', foreign_key: 'fp_id'
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'

  validates :fp_id, presence: true
  validates :guest_id, presence: true
  validates :start_at, presence: true
  validates :reservation_date, presence: true

  validate :reservation_time_check

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
    frame_min  = (60 * 30) # 30分
    self.end_at = (Time.parse(self.start_at) + frame_min).strftime("%H:%M")
    save!
  end

  def reservation_time_check
    errors.add(:reservation_date, "予約可能日は明日以降可能です。") and return if before_today?
    errors.add(:reservation_date, "既に予約されています。") and return if already_reserved?
    errors.add(:reservation_date, "日曜日は予約できません。") and return if self.reservation_date.sunday?
    errors.add(:reservation_date, "この時間帯は予約ができません") and return if fp_ng_time?
    if self.reservation_date.saturday?
      errors.add(:start_at, "時間外の予約はできません。土曜日の予約時間帯は11:00 ~ 15:00です。") unless between_saturday_time?
    else
      errors.add(:start_at, "時間外の予約はできません。平日の予約時間帯は10:00 ~ 18:00です。") unless between_weekday_time?
    end
  end

  def before_today?
    self.reservation_date <= Time.now 
  end

  def already_reserved?
    Reservation.where(reservation_date: self.reservation_date.strftime("%Y-%m-%d"), start_at: self.start_at).count > 1
  end

  def fp_ng_time?
    time_frame = TimeFrame.find_by(start_at: self.start_at)
    return true if time_frame.nil?
    if self.reservation_date.saturday?
      FpNgTimeFrame.where(user_id: self.fp_id, time_frame_id: time_frame.id, is_holiday: true).count > 0
    else
      FpNgTimeFrame.where(user_id: self.fp_id, time_frame_id: time_frame.id, is_weekday: true).count > 0
    end
  end

  def between_saturday_time?
    saturday_day_start_hour = 11
    saturday_day_end_hour   = 14
    start_time = Time.parse(self.start_at)
    saturday_day_start_hour <= start_time.hour.to_i && start_time.hour.to_i <= saturday_day_end_hour
  end

  def between_weekday_time?
    week_day_start_hour = 10
    week_day_end_hour   = 17
    start_time = Time.parse(self.start_at)
    (week_day_start_hour <= start_time.hour.to_i && start_time.hour.to_i <= week_day_end_hour)
  end
end
