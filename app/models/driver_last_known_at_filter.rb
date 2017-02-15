class DriverLastKnownAtFilter

  def filter(drivers, driver_criteria)
    current_time = Time.now
    drivers.select{|d| d.last_known_at && ((current_time - d.last_known_at) < 10.minutes) }
  end
end
