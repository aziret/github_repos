Rails.application.routes.draw do
  root 'repositories#index'
  post '/repositories/search', to: 'repositories#search'
end
