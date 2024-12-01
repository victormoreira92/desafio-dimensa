FactoryBot.define do
  factory :content_file do
    content_file_name { Faker::Lorem.sentence(word_count: 4) }
  end

  trait :com_arquivo_csv do
    after(:build) do |content_file|
      csv_file = File.open(Rails.root.join('spec', 'fixtures', 'arquivos', 'dummy.csv'), 'r')

      content_file.file_data.attach(
        io: csv_file,
        filename: 'dummy.csv',
        content_type: 'text/csv'
      )
    end
  end

  trait :com_arquivo_em_outro_formato do
    after(:build) do |content_file|
      txt_file = File.open(Rails.root.join('spec', 'fixtures', 'arquivos', 'dummy.txt'), 'r')

      content_file.file_data.attach(
        io: txt_file,
        filename: 'dummy.txt',
        content_type: 'plain/txt'
      )
    end
  end
end
