FactoryGirl.define do
  factory :software_company do
    name { Faker::Team.name }
    url_alias { name.underscore.parameterize if name }
    website 'http://example.com'
    about { Faker::Lorem.paragraph }
    number_of_employees { rand(10..1000) }
    contacts { Faker::Address.street_address }
    vat { Faker::Company.australian_business_number }
  end
end
