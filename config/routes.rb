Rails.application.routes.draw do

  # 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# ユーザー
  scope module: :public do
  # homes
    root to: "homes#top"

  # users
  get "/users/my_page"=>"users#my_page",as: 'my_page'
    resources :users, only: [:index, :show, :update, :edit] do
    # relationships
      resources :relationships, only: [:create, :destroy, :following, :follower]
    # reports
      resources :reports, only: [:new, :create]
    end
    get "/users/unsubscribe"=>"users#unsubscribe",as: 'unsubscribe'
    patch "/users/withdraw"=>"users#withdraw"


  # posts
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      # bookmarks
      resources :bookmarks, only: [:index, :create, :destroy]
    end

  # comments
    resources :comments, only: [:index, :create, :destroy]

  end

# 管理者
  namespace :admin do
    root to: "users#index"
  # posts
    resources :posts, only: [:index, :show, :destroy]
  # users
    resources :users, only: [:show, :edit, :update]
  # tags
    resources :tags, only: [:index, :create, :destroy]
  # reports
    resources :reports, only: [:index, :show, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
