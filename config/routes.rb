Chekhov::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  get '/welcome' => 'site#welcome'
  get '/access_denied' => 'site#access_denied'

  match '/auth' => 'site#auth', via: [:get, :post]
  
  resources :checklists
  resources :templates
  
  root 'site#welcome'
end
