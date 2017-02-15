class DriverLocationFilter


  def filter(drivers, driver_criteria)
    drivers.where("ST_DWithin(driver_locations.latlong,
      ST_GeographyFromText('SRID=4326;POINT(:lon :lat)'), :distance)",
       lon: driver_criteria.longitude.to_f,
       lat: driver_criteria.latitude.to_f,
       distance: driver_criteria.radius)
    .order("ST_Distance(driver_locations.latlong,
      ST_GeographyFromText('SRID=4326;POINT(#{driver_criteria.longitude.to_f} #{driver_criteria.latitude.to_f})'))")
  end
end
