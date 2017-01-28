class DriversController < ApplicationController
  before_action :validate_input, only: [:location]
  def index
    driver_search_request = DriverSearchRequest.new(search_params)
    unless driver_search_request.valid?
      render json: {errors: driver_search_request.errors.full_messages}, status: 400
      return
    end
    search_results = DriverLocation.within(driver_search_request)
    # wanted to use jbuilder
    formated_results = search_results.map do |dl|
     {id: dl.driver_id, latitude: dl.latlong.y, longitude: dl.latlong.x, distance: 10}
    end
    render json: formated_results, status: :ok
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
