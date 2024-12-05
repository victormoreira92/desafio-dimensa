FactoryBot.define do
  factory :content_genre do
    association :content
    association :genre
  end
end
