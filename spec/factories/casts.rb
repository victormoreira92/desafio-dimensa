FactoryBot.define do
  factory :cast do
    cast_name { Faker::Name.name_with_middle }
  end
end
