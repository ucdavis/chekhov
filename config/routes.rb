Chekhov::Application.routes.draw do
  resources :checklists
  resources :templates
  
  root 'templates#index'
end
