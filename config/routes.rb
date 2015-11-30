Rails.application.routes.draw do

  namespace :api do
    resources :jokes do
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
  end

  devise_for :users

  resources :jokes do
    member do
      get "upvote", to: "jokes#upvote"
      get "downvote", to: "jokes#downvote"
    end
    resources :comments do
      member do
        get "upvote", to: "comments#upvote"
        get "downvote", to: "comments#downvote"
      end
    end
  end

  get "languages", to: "tags#index"
  get "languages/:id", to: "tags#show"

  resources :tags

  get ":page", to: "pages#show"
  get "pages/:page", to: "pages#show"

  root 'jokes#index'

end
