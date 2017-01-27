class DriverLocation
  include ActiveModel::Validations
  attr_accessor :latitude, :longitude, :accuracy, :driver_id

  validates_presence_of :latitude, :longitude, :accuracy
  validates :latitude,
   numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90, message: "should be between +/- 90" }
  validates :longitude,
    numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90, message: "should be between +/- 90" }
  validates :accuracy,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1, message: "should be between 0 to 1" }


  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def valid_driver?
    driver_id && (-1..50_000).include?(driver_id.to_i)
  end

end
