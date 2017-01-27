class DriversController < ApplicationController
  before_action :validate_input, only: [:location]
  def index
    render json: {result: 1}
  end

  def location
  end

  private

  def validate_input
    @driver_location = DriverLocation.new(params.slice(:latitude, :longitude, :accuracy, :driver_id))
    unless @driver_location.valid_driver?
      render json: {}, status: :not_found
      return
    end
    unless @driver_location.valid?
      render json: {errors: @driver_location.errors.full_messages}, status: 422
      return
    end
  end
end
