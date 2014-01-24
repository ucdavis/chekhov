Chekhov::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  get '/welcome' => 'site#welcome'
  get '/access_denied' => 'site#access_denied'
  
  resources :checklists
  resources :templates
  
  root 'site#welcome'
end
