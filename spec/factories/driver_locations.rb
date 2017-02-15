FactoryGirl.define do
  factory :driver_location do
    sequence(:driver_id) { |n| n }
    latitude 1.01
    longitude 2.02
    accuracy 0.7
    last_known_at { Time.now }

    trait :far_of do
      latitude 10.1
      longitude 20.2
    end
  end
end
