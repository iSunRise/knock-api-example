FactoryGirl.define do
  factory :office do
    software_company
    sequence(:priority) { |n| n }
    country { Faker::Address.country }
    city { Faker::Address.city }
    details { Faker::Lorem.sentence }
    phones { 3.times.map { Faker::PhoneNumber.cell_phone } }
    emails { 3.times.map { Faker::Internet.email } }
    working_times do
      {
          "Monday - Fri" => "9:00 - 18:00",
          "Saturday"     => "9:00 - 15:00",
          "Sunday"       => ""
      }
    end
  end
end
