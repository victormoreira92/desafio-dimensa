FactoryBot.define do
  factory :conteudo do
    title { Faker::Movie.title }
    type_conteudo { 0 }
    show_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    published_at { (1..12).to_a.sample.months.ago }
    year { (2000..2023).to_a.sample }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    duration { (60..180).to_a.sample }
    type_duration { 0 }
  end

  trait :tv_show do
    type_conteudo { 0 }
    duration { (1..12).to_a.sample }
    type_duration { 1 }
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
