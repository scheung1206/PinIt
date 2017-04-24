Rails.application.routes.draw do
  # get 'rooms/index'
  #
  # get 'rooms/create'
  #
  # get 'rooms/party'

  get 'rooms/config_opentok'

  get 'chat/home'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  resources :friendships
  resources :users
  resources :pins do
    resources :comments, except: [:show, :index]
    collection do
      get 'search'
    end
  	member do

  		put "like", to: "pins#upvote"
  	end
  end
  get 'mine', to: 'pins#mine'
  get 'following', to: 'pins#following'
  #get "users/sign_up"
  root "pins#index"
  # get 'users', to: "users#index", as: "users"
  # get 'users/:id', to: "users#show", as: "user"

  resources :rooms
  match '/party/:id', :to => "rooms#party", :as => :party, :via => :get

end
