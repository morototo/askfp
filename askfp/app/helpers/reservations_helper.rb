module ReservationsHelper
  def business_time(day, options={})
    select_items = []
    return select_items if day.sunday?

    start_hour = !day.saturday? ? 10 : 11
    start_min  = 00

    end_hour = !day.saturday? ? 18 : 15
    end_min  = 00

    repeat_num = end_hour - start_hour
    if repeat_num < 0
      repeat_num *= -1
    end
    repeat_num *= 2

    if start_min > end_min
      repeat_num -= 1
    elsif start_min < end_min
      repeat_num += 1
    end

    repeat_num.times do
      select_items << [
        "#{format('%02d', start_hour)}:#{format('%02d', start_min)}",
        "#{format('%02d', start_hour)}:#{format('%02d', start_min)}"
      ]
      start_min += 30
      if start_min == 60
        start_hour += 1
        start_min = 0
        if start_hour == 24
          start_hour = 0
        end
      end
    end
    select_items
  end
end
