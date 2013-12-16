Chekhov::Application.routes.draw do
  get '/welcome' => 'site#welcome'
  get '/access_denied' => 'site#access_denied'
  
  resources :checklists
  resources :templates
  
  root 'site#welcome'
end
