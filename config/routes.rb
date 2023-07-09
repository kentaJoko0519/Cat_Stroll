Rails.application.routes.draw do

# 顧客用
# URL /usrs/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
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
    get "/privacy"=>"homes#privacy",as: 'privacy'
    get "/help"=>"homes#help",as: 'help'

    # users
    get "/users/my_page"=>"users#my_page",as: 'my_page'
    get "/users/unsubscribe"=>"users#unsubscribe",as: 'unsubscribe'
    patch "/users/withdraw"=>"users#withdraw"
    resources :users, only: [:index, :show, :update, :edit] do
      # relationships
      resource :relationships, only: [:create, :destroy, :follower]
      get "/relationships/following"=>"relationships#following",as: 'following'
      get "/relationships/follower"=>"relationships#follower",as: 'follower'
      # reports
      resources :reports, only: [:new, :create]
    end
    get 'users/:id/reports' => redirect("/users/%{id}/reports/new")
    
    # posts
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      # bookmarks
      resource :bookmarks, only: [:create, :destroy]
      get "/bookmarks/favorite"=>"bookmarks#favorite",as: 'favorite'
    end
    
    # comments
    resources :comments, only: [:create, :destroy]

  end

# 管理者
  namespace :admin do
    root to: "users#index"
  # posts
    resources :posts, only: [:index, :show, :destroy]
  # users
    resources :users, only: [:show, :edit, :update]
  # reports
    resources :reports, only: [:index, :show, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
