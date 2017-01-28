class DriverSearchRequest
  include ActiveModel::Validations
  attr_accessor :latitude, :longitude, :radius, :limit
  DEFAULT_OPTIONS = {radius: 500, limit: 10}

  validates_presence_of :latitude, :longitude
  validates :latitude,
   numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90, message: "should be between +/- 90" }
  validates :longitude,
    numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180, message: "should be between +/- 180" }
  validates :radius,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10_000, message: "should be between 0 to 10,000", allow_nil: true }
  validates :limit,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: "should be between 0 to 100", allow_nil: true }


  def initialize(attributes = {})
    DEFAULT_OPTIONS.merge(attributes).each do |name, value|
      send("#{name}=", value)
    end
  end

end
