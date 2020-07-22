Rails.application.routes.draw do
  resources :import_files
  root 'import_files#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
