Rails.application.routes.draw do
  namespace :public do
    get 'homes/about'
  end
  # ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  :omniauth_callbacks => 'public/omniauth_callbacks'
}
devise_scope :user do
    post 'guest_sign_in', to:'public/sessions#guest_sign_in'
end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    resources :posts do
      collection do
        get 'search'
        get 'confirm'
        get 'rank'
      end
    end
    
    resources :bookmarks, only: [:show, :edit, :update]
    
    resources :posts, only: [:new, :show, :edit, :index]do
      delete 'posts/:id' => 'posts#destroy', as: 'destroy_posts'
      resources :post_comments, only: [:create, :destroy]
    end
    # resource :favorites, only: [:create, :destroy]
    patch 'posts/:id' => 'posts#update', as: 'update_post'
    post 'posts' => 'posts#create'
    
    resource :favorites, only: [:create, :destroy]
    post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
    delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'


    resources :users, only: [:show, :edit]
    patch 'users/:id' => 'users#update', as: 'update_user'

    resources :users do
      member do
        get :favorites
      end
    end

    resources :lists, only: [:index, :show]

    root to: 'posts#index'
    #post '/sessions/guest_sign_in', to: 'sessions#guest_sign_in'

    resources :notifications, only: [:index]
 
    resources :boards, only: [:new, :show, :index, :create, :edit]do
      delete 'boards/:id' => 'boards#destroy', as: 'destroy_board'
      patch 'boards/:id' => 'boards#update', as: 'update_board'
      resources :board_comments, only: [:create]
      delete 'board_comments/:id' => 'board_comments#destroy', as: 'destroy_board_comment'
    end
  end
  
  namespace :admin do
    resources :users do
      collection do
        get 'search'
      end
    end
    resources :users, only: [:index, :show, :edit, :show]
    patch 'users/:id' => 'users#update', as: 'update_user'

    resources :tags, only: [:index, :create, :edit, :update]

    resources :posts, only: [:index, :show, :edit] do
      resources :post_comments, only: [:create, :destroy]
    end
    get 'posts/:id/edit' => 'posts#edit', as: 'edit_post'
    delete 'posts/:id' => 'posts#destroy', as: 'destroy_post'
    patch 'posts/:id' => 'posts#update', as: 'update_post'

    resources :softwares, only: [:new, :index, :create, :edit]
    patch 'softwares/:id' => 'softwares#update', as: 'update_software'
    delete 'softwares/:id' => 'softwares#destroy', as: 'destroy_software'
    
    resources :boards, only: [:new, :show, :index, :create, :edit]do
      delete 'boards/:id' => 'boards#destroy', as: 'destroy_board'
      patch 'boards/:id' => 'boards#update', as: 'update_board'
      resources :board_comments, only: [:create]
      delete 'board_comments/:id' => 'board_comments#destroy', as: 'destroy_board_comment'
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
