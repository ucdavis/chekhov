Chekhov::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  get '/access_denied' => 'site#access_denied'
  get '/status' => 'site#status', defaults: { format: 'json'}
  get '/showChecklist/:id' => 'site#show_checklist'
  get '/archiveChecklist/:id' => 'site#archive_checklist'

  match '/auth' => 'site#auth', via: [:get, :post]

  resources :checklists
  resources :templates
  resources :checklist_categories
  resources :template_categories
  resources :analytics

  root 'templates#index'
end
