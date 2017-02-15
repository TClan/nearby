class DriverLimitFilter

  def filter(drivers, driver_criteria)
    drivers.limit(driver_criteria.limit)
  end
end
