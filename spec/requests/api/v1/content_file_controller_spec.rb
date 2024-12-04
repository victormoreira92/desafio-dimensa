require 'rails_helper'

RSpec.describe "Api::V1::ContentFiles", type: :request do
  let!(:csv_file) { fixture_file_upload(Rails.root.join('spec/fixtures/arquivos/arquivo_teste.csv'), 'text/csv') }
  let!(:arquivo_com_outro_formato) { fixture_file_upload(Rails.root.join('spec/fixtures/arquivos/dummy.txt'), 'plain/txt') }
  let!(:arquivo_com_outra_header) { fixture_file_upload(Rails.root.join('spec/fixtures/arquivos/dummy.csv'), 'text/csv') }
  let!(:csv_vazio) { fixture_file_upload(Rails.root.join('spec/fixtures/arquivos/vazio.csv'), 'text/csv') }
  let!(:content_file) { build(:content_file, :com_arquivo_teste)}

  describe '/process_csv' do
    context 'com parametros válidos e retorno success: true' do
      it 'csv válido anexado e content_filename' do
        expect { post '/api/v1/content_files/process_csv', params: { content_file: {
          content_file_name: content_file.content_file_name,
          file_data: csv_file
        }}}.to change { ContentFile.count }.by(1)
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['status']).to eq('success')
        expect(JSON.parse(response.body)['message']).to eq(I18n.t('activerecord.success.models.content_files.process_csv',contents: 4))
      end
    end

    context 'quando o retorno é sucesso:false' do
      it 'sem content_filename' do
        post '/api/v1/content_files/process_csv', params: { content_file: {
          content_file_name: nil,
          file_data: csv_file
        }}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['message']).to include('Nome de Arquivo não pode ficar em branco')
      end

      it 'file_data em outro formato csv' do
        post '/api/v1/content_files/process_csv', params: { content_file: {
          content_file_name: content_file.content_file_name,
          file_data: arquivo_com_outro_formato
        }}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['message']).to include('Arquivo de Dados não está em formato CSV')
      end

      it 'file_data com header diferente do modelo' do
        post '/api/v1/content_files/process_csv', params: { content_file: {
          content_file_name: content_file.content_file_name,
          file_data: arquivo_com_outra_header
        }}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['message']).to include('Arquivo de Dados faltando as colunas: show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description')
      end

      it 'file_data com csv vazio' do
        post '/api/v1/content_files/process_csv', params: { content_file: {
          content_file_name: content_file.content_file_name,
          file_data: csv_vazio
        }}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['message']).to include('Arquivo de Dados vazio')
      end
    end
  end

end
