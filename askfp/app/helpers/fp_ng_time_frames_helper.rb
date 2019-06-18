module FpNgTimeFramesHelper
  def is_between_weekday_time?(strat_at)
    bussiness_start_time = 10
    bussiness_end_time   = 17
    start_at_time = Time.parse(strat_at)
    bussiness_start_time <= start_at_time.hour && start_at_time.hour <= bussiness_end_time
  end

  def is_between_holiday_time?(strat_at)
    bussiness_start_time = 11
    bussiness_end_time   = 14
    start_at_time = Time.parse(strat_at)
    bussiness_start_time <= start_at_time.hour && start_at_time.hour <= bussiness_end_time
  end
end
