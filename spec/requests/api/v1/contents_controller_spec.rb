require 'rails_helper'

RSpec.describe "Api::V1::Contents", type: :request do
  let!(:genres){ create_list(:genre, 3) }
  let!(:countries){ create_list(:country, 3)}
  let!(:casts) { create_list(:cast, 5)}
  let!(:content_file) { create(:content_file, :com_arquivo_teste)}
  let!(:contents_movie) do
    10.times do
      content = create(:content, content_file: content_file)
      content.casts <<  casts.sample
      content.genres << genres.sample
      content.countries << countries.sample
    end
  end
  let!(:contents_tv_show) do
    10.times do
      content = create(:content, :tv, content_file: content_file)
      content.casts <<  casts.sample
      content.genres << genres.sample
      content.countries << countries.sample
    end
  end


  describe "GET /index" do
    context 'by_genre' do
     it 'com genre presente' do
      genre_name = genres.sample.genre_name
      numeros_de_contents_com_genre = Content.by_genre(genre_name).size
      get '/api/v1/contents', params: { by_genre: genre_name }
      expect(JSON.parse(response.body).size).to eq(numeros_de_contents_com_genre)
      expect(response).to have_http_status(:ok)
     end

     it 'com genre não presente' do
      genre_name = 'vazio'
      numeros_de_contents_com_genre = Content.by_genre(genre_name).size
      get '/api/v1/contents', params: { by_genre: genre_name }
      expect(JSON.parse(response.body).size).to eq(numeros_de_contents_com_genre)
      expect(response).to have_http_status(:ok)
     end
    end

    context 'by_title' do
      it 'com title presente' do
       title = Content.all.sample.title
       numeros_de_registros = Content.by_title(title).size
       get '/api/v1/contents', params: { by_title: title }
       expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
       expect(response).to have_http_status(:ok)
      end

      it 'com title não presente' do
        title = 'vazio'
        numeros_de_registros = Content.by_title(title).size
        get '/api/v1/contents', params: { by_title: title }
        expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'by_country' do
      it 'com country presente' do
       country_name = countries.sample.country_name
       numeros_de_registros = Content.by_country(country_name).size
       get '/api/v1/contents', params: { by_country: country_name }
       expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
       expect(response).to have_http_status(:ok)
      end

      it 'com country não presente' do
        country_name = 'vazio'
        numeros_de_registros = Content.by_country(country_name).size
        get '/api/v1/contents', params: { by_country: country_name }
        expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'by_type_content' do
      it 'com type_content movie' do
       numeros_de_registros = Content.by_type_content('movie').size
       get '/api/v1/contents', params: { by_type_content: 'movie' }
       expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
       expect(response).to have_http_status(:ok)
      end

      it 'com type_content tv_show' do
        numeros_de_registros = Content.by_type_content('tv_show').size
        get '/api/v1/contents', params: { by_type_content: 'tv_show' }
        expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'by_cast' do
      it 'com nome de Cast presente' do
        cast_name = casts.sample.cast_name
        numeros_de_registros = Content.by_cast(cast_name).size
        get '/api/v1/contents', params: { by_cast: cast_name }
        expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
        expect(response).to have_http_status(:ok)
      end

      it 'nome Cast não presente' do
        cast_name = 'vazio'
        numeros_de_registros = Content.by_cast(cast_name).size
        get '/api/v1/contents', params: { by_cast: cast_name }
        expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'by_year_range' do
      it 'com started_at menor que ended_at' do
        numeros_de_registros = Content.by_year_range(2001, 2004).size
        get '/api/v1/contents', params: { by_year_range: { started_at: 2001, ended_at: 2004 } }
        expect(JSON.parse(response.body).size).to eq(numeros_de_registros)
        expect(response).to have_http_status(:ok)
      end

      it 'com started_at maior que ended_at' do
        numeros_de_registros = Content.by_year_range(2004, 2001).size
        get '/api/v1/contents', params: { by_year_range: { started_at: "2004", ended_at: "2001" } }
        expect(JSON.parse(response.body).size).to eq(0)
        expect(response).to have_http_status(:ok)
      end

    end
  end
end
