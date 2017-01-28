require 'rails_helper'

describe DriverSearchRequest do
  describe '#latitude' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to allow_value(90, -90, 0).for(:latitude) }
    it { is_expected.not_to allow_value(91, -91).for(:latitude) }
  end

  describe '#longitude' do
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to allow_value(180, -180, 0).for(:longitude) }
    it { is_expected.not_to allow_value(181, -181).for(:longitude) }
  end

  describe '#radius' do
    it { is_expected.not_to validate_presence_of(:radius) }
    it { is_expected.to allow_value(1, 100, 500).for(:radius) }
    it { is_expected.not_to allow_value(10_001).for(:radius) }
  end

  describe '#limit' do
    it { is_expected.not_to validate_presence_of(:limit) }
    it { is_expected.to allow_value(1, 10, 50).for(:limit) }
    it { is_expected.not_to allow_value(101).for(:limit) }
  end
end

