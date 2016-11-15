FactoryGirl.define do
  factory :account do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    middle_name { Faker::Name.first_name }
    roles [Account::SUPERADMIN]
    password 'password'
    password_confirmation 'password'
    position { Faker::Name.title }
    software_company_name { Faker::Team.name }
  end
end
