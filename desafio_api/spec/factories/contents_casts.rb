FactoryBot.define do
  factory :content_cast do
    association :content
    association :cast
  end
end
