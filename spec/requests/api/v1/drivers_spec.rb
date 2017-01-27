require 'rails_helper'

describe "Drivers API" do
  it 'sends a list of messages' do

    get '/api/v1/drivers'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json['result']).to eq(1)
  end
end
