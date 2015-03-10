Chekhov::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  get '/welcome' => 'site#welcome'
  get '/access_denied' => 'site#access_denied'
  get '/status' => 'site#status', defaults: { format: 'json'}

  match '/auth' => 'site#auth', via: [:get, :post]
  
  resources :checklists
  resources :templates
  resources :analytics
  
  root 'site#welcome'
end
