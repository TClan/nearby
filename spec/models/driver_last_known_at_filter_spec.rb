require 'rails_helper'

describe DriverLastKnownAtFilter do
  describe '#filter' do
    let!(:driver_with_recent_location) {create(:driver_location)}
    let!(:driver_with_stale_location) {create(:driver_location, last_known_at: (Time.now - 20.minutes))}
    it 'filters by time' do
      filtered_results =
        DriverLastKnownAtFilter.new.filter([driver_with_stale_location, driver_with_recent_location], nil)
      expect(filtered_results.size).to be 1
    end
  end
end
