FactoryBot.define do
  factory :arquivo_dado_filme do
    nome_arquivo { Faker::Lorem.sentence(word_count: 4) }
  end

  trait :com_arquivo_csv do
    after(:build) do |arquivo_dado_filme|
      csv_file = File.open(Rails.root.join('spec', 'fixtures', 'arquivos', 'dummy.csv'), 'r')

      arquivo_dado_filme.arquivo.attach(
        io: csv_file,
        filename: 'dummy.csv',
        content_type: 'text/csv'
      )
    end
  end

  trait :com_arquivo_em_outro_formato do
    after(:build) do |arquivo_dado_filme|
      txt_file = File.open(Rails.root.join('spec', 'fixtures', 'arquivos', 'dummy.txt'), 'r')

      arquivo_dado_filme.arquivo.attach(
        io: txt_file,
        filename: 'dummy.txt',
        content_type: 'plain/txt'
      )
    end
  end
end
