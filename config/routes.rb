Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "homes#top"


  # 一般的な検索用のルート
  get "search" => "searches#search"

  # ユーザー関連のルート
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users do
    member do
      get :following, :followers
    end
    collection do
      get 'search', as: :search
    end
  end

  # ポスト関連のルート
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments # コメントリソースをpostsリソース内にネスト
    resources :maps # Postに関連するMapエンドポイントをネスト

    collection do
      get 'search', as: :search
    end
  end

  # マップ関連のルート
  resources :maps, only: [:index, :show] do
    collection do
      get 'search', as: :search
    end
  end

  resources :follows, only: [:create, :destroy]

  resources :search_results, only: [:index]

  resources :reports, only: [:new, :create]
end
