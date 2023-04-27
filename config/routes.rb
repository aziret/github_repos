Rails.application.routes.draw do
  root 'repositories#index'
  get '/repositories/search', to: 'repositories#search'
end
