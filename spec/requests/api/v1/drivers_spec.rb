require 'rails_helper'

describe 'Drivers API V1' do

  describe '#get drivers' do
    it 'get driver locations' do

      get '/api/v1/drivers'

      expect(response).to be_success
    end
  end

  describe '#update drivers' do
    it 'validates lat and long' do

      put '/api/v1/drivers/1/location', {latitude: 91, longitude: -91, accuracy: 0.7}

      expect(response).to have_http_status(422)
      json_body = JSON.parse(response.body)
      expect(json_body['errors']).to include("Latitude should be between +/- 90")
      expect(json_body['errors']).to include("Longitude should be between +/- 90")
    end

    it 'validates driver range' do

      put '/api/v1/drivers/50001/location', {latitude: 1, longitude: -1, accuracy: 0.7}

      expect(response).to have_http_status(404)
    end
  end

end
