class DriverLocation < ActiveRecord::Base
  attr_accessor :latitude, :longitude

  validates_presence_of :latitude, :longitude, :accuracy, :driver_id
  validates :latitude,
   numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90, message: "should be between +/- 90" }
  validates :longitude,
    numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180, message: "should be between +/- 180" }
  validates :accuracy,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1, message: "should be between 0 to 1" }

  def self.within(dsr)
    where("ST_DWithin(driver_locations.latlong,
      ST_GeographyFromText('SRID=4326;POINT(:lon :lat)'), :distance)", lon: dsr.longitude.to_f, lat: dsr.latitude.to_f, distance: dsr.radius
      ).limit(dsr.limit)
  end

  before_save :set_latlong


  def valid_driver?
    driver_id && (-1..50_000).include?(driver_id.to_i)
  end

  private

    def set_latlong
      self.latlong = "POINT(#{longitude} #{latitude})"
    end

end
