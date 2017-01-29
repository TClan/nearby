require 'rails_helper'

describe 'Record driver locations and provide nearby drivers from a specified point', type: :request do
  it 'Drivers are close to specified location' do
    put '/api/v1/drivers/300/location', {latitude: 1.101, longitude: 2.201, accuracy: 0.7}
    put '/api/v1/drivers/100/location', {latitude: 1.101, longitude: 2.202, accuracy: 0.7}
    put '/api/v1/drivers/400/location', {latitude: 5.101, longitude: 6.202, accuracy: 0.7}

    get '/api/v1/drivers', {latitude: 1.101, longitude: 2.201}

    expect(response).to have_http_status(200)
    json_body = JSON.parse(response.body)
    expect(json_body.length).to eql(2)
    expect(json_body[0]["id"]).to eql(300)
    expect(json_body[1]["id"]).to eql(100)
  end
end
