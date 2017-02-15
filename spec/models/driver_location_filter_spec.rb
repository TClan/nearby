require 'rails_helper'

describe DriverLocationFilter do
  describe '#filter' do
    let(:driver_criteria) { build(:driver_search_request) }
    let!(:drivers) { create_list(:driver_location, 2)}
    let!(:driver_out_of_range) {create(:driver_location, :far_of)}
    it 'filter by location' do
      expect(DriverLocationFilter.new.filter(DriverLocation, driver_criteria).count).to be 2
    end
  end
end
