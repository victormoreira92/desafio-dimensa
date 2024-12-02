FactoryBot.define do
  factory :content_country do
    association :content
    association :country
  end
end
