Rails.application.routes.draw do

  root 'welcome#index'
  
  get 'charges/create'
  get 'about' => 'welcome#about'
  
  devise_for :users
  
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end
  
  resources :charges, only: [:new, :create]
  
  resources :users, only: [:index, :show] do
    member do
      post :downgrade
    end
  end
  
end
