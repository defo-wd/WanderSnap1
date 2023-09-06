Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users
  resources :posts do
    resources :comments
  end
  resources :maps

end
