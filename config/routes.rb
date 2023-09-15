Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments # コメントリソースをpostsリソース内にネスト
    resources :maps # Postに関連するMapエンドポイントをネスト
  end

  resources :maps, only: [:index, :show] # 全てのマップを閲覧、個別のマップの詳細の表示
  resources :users

  resources :follows, only: [:create, :destroy]
end
