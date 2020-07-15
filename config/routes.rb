Rails.application.routes.draw do
  get '/', to: 'shelters#index' #eventually change this to a welcome/home page

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets_index'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  post 'pets/:id/favorites', to: 'favorites#create'
  get '/favorites', to: 'favorites#index'
  delete '/favorites/:id', to: 'favorites#destroy'
  delete '/favorites', to: 'favorites#destroy_all'

  get 'favorites/application', to: 'apps#new'
  #get '/applications', to: 'apps#create'
  post '/applications', to: 'apps#create'
  get 'applications/:id', to: 'apps#show'
  get '/pets/:id/applications', to: 'apps#index'
  patch "/applications/:id/:pet_id/:pet_status", to: 'apps_pet#update_status'
end
