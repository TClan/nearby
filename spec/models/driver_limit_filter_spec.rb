require 'rails_helper'
describe DriverLimitFilter do
  describe '#filter' do
    let!(:drivers) {create_list(:driver_location, 3)}
    let(:driver_criteria) {build(:driver_search_request, limit: 2)}
    it 'limits the drivers to specified count' do
      expect(DriverLimitFilter.new.filter(DriverLocation, driver_criteria).count).to eql(2)
    end
  end
end
