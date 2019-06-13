48.times.map.each_with_index do |i|
  TimeFrame.seed do |s|
    time = Time.parse("00:00")+30.minutes*i
    s.id = i + 1
    s.start_at = time.strftime("%H:%M")
  end
end
