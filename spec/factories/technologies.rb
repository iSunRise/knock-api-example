FactoryGirl.define do
  factory :technology do
    sequence(:name) { |n| Faker::Team.sport + n.to_s }
  end
end
