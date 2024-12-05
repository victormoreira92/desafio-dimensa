FactoryBot.define do
  factory :genre do
    genre_name { Faker::Book.genre }
  end
end
