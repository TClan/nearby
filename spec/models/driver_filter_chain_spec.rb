require 'rails_helper'

describe DriverFilterChain do
  describe '#filter' do
    let(:driver_criteria) {build(:driver_search_request)}
    let!(:drivers) do
      [
        create(:driver_location, driver_id: 100),
        create(:driver_location, last_known_at: (Time.now - 20.minutes)),
        create(:driver_location, latitude: 10.1, longitude: 20.2)
      ]
    end
    it 'applies multiple filters' do
      filtered_results = DriverFilterChain.new.filter(DriverLocation.all, driver_criteria)
      expect(filtered_results.size).to be 1
      expect(filtered_results.first.driver_id).to eql(100)
    end
  end
end
