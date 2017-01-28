class DriversController < ApplicationController
  before_action :validate_input, only: [:location]
  def index
    @driver_search = DriverSearchRequest.new(search_params)
    unless @driver_search.valid?
      render json: {errors: @driver_search.errors.full_messages}, status: 400
      return
    end
  end

  def location
    begin
      latest_location = DriverLocation.find_by_driver_id!(@driver_location.driver_id)
      latest_location.update_attributes!(location_params)
    rescue ActiveRecord::RecordNotFound
      @driver_location.save!
    end
    render nothing: true, status: :ok
  end

  private

  def validate_input
    @driver_location = DriverLocation.new(location_params)
    unless @driver_location.valid_driver?
      render json: {}, status: :not_found
      return
    end
    unless @driver_location.valid?
      render json: {errors: @driver_location.errors.full_messages}, status: 422
      return
    end
  end

  def location_params
    params.permit(:latitude, :longitude, :accuracy, :driver_id)
  end

  def search_params
    params.permit(:latitude, :longitude, :radius, :limit)
  end
end
