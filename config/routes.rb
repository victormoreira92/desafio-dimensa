Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :contents, only: [:index]
      post '/content_files/process_csv', to: 'content_files#process_csv'
    end
  end
  root to: 'api/v1/contents#index'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
