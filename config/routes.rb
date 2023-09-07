Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  resources :posts do
    resources :comments
    resources :maps # Postに関連するMapエンドポイントをネスト
  end

  resources :maps, only: [:index, :show] # 全てのマップを閲覧、個別のマップの詳細の表示

end
