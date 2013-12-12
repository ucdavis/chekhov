Chekhov::Application.routes.draw do
  resources :checklist_entries
  resources :checklists
  resources :template_entries
  resources :templates

  root 'templates#index'
end
