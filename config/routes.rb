Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :posts
      resources :children, only: %i[index]
      resources :parents, only: %i[index]
      resources :people, only: %i[index]
      resource :family, only: %i[show]
      resource :random_person, only: %i[show]
    end
  end
end
