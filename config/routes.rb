Rails.application.routes.draw do

  devise_for :users
  
  resources :wikis

  resources :charges, only: [:new, :create]

  get 'my_wikis' => 'wikis#my_wikis'
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
