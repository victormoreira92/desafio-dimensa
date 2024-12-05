# MovieInformationAPI

Aplciação em Rails para visualização de dados de filmes e séries.


## Dependecias
 * Ruby Version: 3.0.2
 * Rails Version: 7.0.2
 * Database: Postgresql
 
## Como funciona

Iniciar o siistema
`rails db:create db:migrate`

 `rails s`

## Endpoints
 *`POST /api/v1/content_files/process_csv`
  
  Ação para anexar arquivo csv para ser, validado e depois processado.

 *`GET /api/v1/content/process_csv`
  
  Ação para mostrar todos os Contents cadastrados no banco de dados.

  ### Filtros: 

 *`GET /api/v1/content/process_csv?by_genre=genre_name`
  
  Filtrar as Obras por nome de genero

 *`GET /api/v1/content/process_csv?by_country=country_name`
  
  Filtrar as Obras por nome de pais


 *`GET /api/v1/content/process_csv?by_title=title`
  
   Filtrar as Obras por titulo de obra


  `GET /api/v1/content/process_csv?by_type_content=content`
  
  Filtrar as Obras por tipo de conteudo('movie') ou (tv_show)

  `GET /api/v1/content/process_csv?by_cast=cast`
  
   Filtrar as Obras por nome de Cast

 `GET /api/v1/content/process_csv?by_year_range[started_at]=year&by_year_range[ended_at]=year`
  
   Filtrar as Obras entre o periodo de tempo, mas sempre o ano de inicio (started_at) deve ser menor que o ano final(ended_at).

  
end

## Modelos Criados
Content_File = Representa o arquivo csv anexado

Content = Representa a obra cinematografica, podendo ser Movie ou Tv_show

Genre = Representa os generos

Cast = Representa os casts

Country = Representa os países

Contents_Genres = Representa a relação muitos para muitos de Content e Genre

Contents_Countries = Representa a relação muitos para muitos de Content e Country

Contents_Casts = Representa a relação muitos para muitos de Content e Cast

## Testes 
 Para executar 
`bundle exec rspec -f d /spec/` 
  Para executar específico
 `bundle exec rspec -f d /spec/`

Realizado testes os seguintes testes:
Models, Services, Request