class DriverFilterChain

  DB_FILTERS = [DriverLocationFilter.new, DriverLimitFilter.new]
  IN_MEM_FILTERS = [DriverLastKnownAtFilter.new]

  def filter(drivers, driver_criteria)
    filtered_drivers = drivers
    [DB_FILTERS, IN_MEM_FILTERS].flatten.each{|f| filtered_drivers = f.filter(filtered_drivers, driver_criteria)}
    filtered_drivers
  end
end
