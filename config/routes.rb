Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
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
  #get "users/sign_up"

  root "pins#index"
  # get 'users', to: "users#index", as: "users"
  # get 'users/:id', to: "users#show", as: "user"

end
