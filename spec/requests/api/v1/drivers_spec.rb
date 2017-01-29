require 'rails_helper'

describe 'Drivers API V1' do

  describe '#get drivers' do
    it 'validates input range' do
      get '/api/v1/drivers', {latitude: 91, longitude: -191}

      expect(response).to have_http_status(400)
      json_body = JSON.parse(response.body)
      expect(json_body['errors']).to include("Latitude should be between +/- 90")
      expect(json_body['errors']).to include("Longitude should be between +/- 180")
    end
    it 'mandatory to provide lat and long' do
      get '/api/v1/drivers', {}

      expect(response).to have_http_status(400)
      json_body = JSON.parse(response.body)
      expect(json_body['errors']).to include("Latitude can't be blank")
      expect(json_body['errors']).to include("Longitude can't be blank")
    end

    context 'when location exist' do
      let!(:location_within_range_near) { DriverLocation.create!(driver_id: 100, latitude: 1.1, longitude: 2.2, accuracy: 0.7) }
      let!(:location_out_of_range) { DriverLocation.create!(driver_id: 200, latitude: 10.1, longitude: 20.2, accuracy: 0.7) }
      it 'fetches location that fall under specified limit' do
        get '/api/v1/drivers', {latitude: 1.101, longitude: 2.201}

        expect(response).to have_http_status(200)
        json_body = JSON.parse(response.body)
        first_result = json_body[0]
        expect(first_result["id"]).to eql(100)
        expect(first_result["longitude"]).to eql(2.2)
        expect(first_result["latitude"]).to eql(1.1)
        expect(first_result["distance"]).to eql(10)
      end

      context 'when multiple locations match search' do
        let!(:location_within_range_nearest) { DriverLocation.create!(driver_id: 300, latitude: 1.101, longitude: 2.201, accuracy: 0.7) }
        it 'fetches location that fall under specified limit sorted by distance' do
          get '/api/v1/drivers', {latitude: 1.101, longitude: 2.201}

          expect(response).to have_http_status(200)
          json_body = JSON.parse(response.body)
          expect(json_body.length).to eql(2)
          expect(json_body[0]["id"]).to eql(300)
          expect(json_body[1]["id"]).to eql(100)
        end
      end
    end
  end

  describe '#update drivers' do
    it 'validates lat and long' do

      put '/api/v1/drivers/1/location', {latitude: 91, longitude: -191, accuracy: 0.7}

      expect(response).to have_http_status(422)
      json_body = JSON.parse(response.body)
      expect(json_body['errors']).to include("Latitude should be between +/- 90")
      expect(json_body['errors']).to include("Longitude should be between +/- 180")
    end

    it 'validates driver range' do

      put '/api/v1/drivers/50001/location', {latitude: 1, longitude: -1, accuracy: 0.7}

      expect(response).to have_http_status(404)
    end

    context 'when driver location does not exist' do
      it 'saves location' do
        put '/api/v1/drivers/100/location', {latitude: 1.1, longitude: 2.2, accuracy: 0.7}
        location = DriverLocation.find_by_driver_id(100)
        expect(location).to be_present
        expect(location.latlong.x).to eql(2.2)
        expect(location.latlong.y).to eql(1.1)
      end
    end

    context 'when driver location exists' do
      let(:last_location) { DriverLocation.create!(driver_id: 100, latitude: 1.1, longitude: 2.2, accuracy: 0.7) }
      it 'overwrites last location' do
        put "/api/v1/drivers/#{last_location.driver_id}/location", {latitude: 1.2, longitude: 2.3, accuracy: 0.8}

        updated_location = DriverLocation.find_by_driver_id(last_location.driver_id)
        expect(updated_location).to be_present
        expect(updated_location.accuracy).to eql(0.8)
        expect(updated_location.latlong.x).to eql(2.3)
        expect(updated_location.latlong.y).to eql(1.2)
      end
    end

  end

end
