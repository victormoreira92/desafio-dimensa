FactoryBot.define do
  factory :content do
    title { Faker::Movie.title }
    type_content { :movie }
    show_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    published_at { (1..12).to_a.sample.months.ago }
    year { (2000..2023).to_a.sample }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    duration { (60..180).to_a.sample }
    type_duration { :minutes }
    association :content_file, :com_arquivo_csv
  end

  trait :tv do
    type_content { :tv_show }
    duration { (1..12).to_a.sample }
    type_duration { :seasons }
  end

  trait :sem_title do
    title { nil }
  end

  trait :sem_description do
    description { nil }
  end

  trait :sem_year do
    year { nil }
  end

  trait :sem_published_at do
    published_at { nil }
  end

  trait :sem_duration do
    duration { nil }
  end
end
