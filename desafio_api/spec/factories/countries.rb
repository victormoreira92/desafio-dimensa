FactoryBot.define do
  factory :country do
    country_name { Faker::Address.country }
  end
end
