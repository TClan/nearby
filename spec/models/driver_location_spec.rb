require 'rails_helper'

describe DriverLocation do
  describe '#latitude' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to allow_value(90, -90, 0).for(:latitude) }
    it { is_expected.not_to allow_value(91, -91).for(:latitude) }
  end

  describe '#longitude' do
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to allow_value(90, -90, 0).for(:longitude) }
    it { is_expected.not_to allow_value(91, -91).for(:longitude) }
  end

  describe '#accuracy' do
    it { is_expected.to validate_presence_of(:accuracy) }
    it { is_expected.to allow_value(0, 0.3, 1).for(:accuracy) }
    it { is_expected.not_to allow_value(-1, 1.2).for(:accuracy) }
  end

  describe '#valid_driver?' do
    it 'should be within range' do
      expect(DriverLocation.new(driver_id: 200)).to be_valid_driver
      expect(DriverLocation.new(driver_id: 200_000)).not_to be_valid_driver
    end
  end
end
