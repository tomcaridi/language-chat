Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  
  root 'home#homepage'
  
  authenticated :user do
    get "/" => 'users#index'
  end

  get "/languages" => "language_choices#new"
  post "/languages" => "language_choices#create"
  get "/languages/edit" => "language_choices#edit"
  patch "/languages" => "language_choices#udpate"
  put "/languages" => "language_choices#udpate"

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :conversations do
    resources :messages
  end
end