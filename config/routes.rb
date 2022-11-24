Rails.application.routes.draw do
  # ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  :omniauth_callbacks => 'public/omniauth_callbacks'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
      resources :users do
    collection do
      get 'search'
        end
    end
  end
  scope module: :public do
      resources :posts do
    collection do
        get 'search'
        #get 'search_pens'
      end
    end
  end
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :show]
    patch 'users/:id' => 'users#update', as: 'update_user'
  end
 
  # devise_for :users
  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update]

  end
  namespace :admin do
    resources :posts, only: [:index, :show, :edit] do
    resources :post_comments, only: [:create, :destroy]
    end
    get 'posts/:id/edit' => 'posts#edit', as: 'edit_post'
    delete 'posts/:id' => 'posts#destroy', as: 'destroy_post'
    patch 'posts/:id' => 'posts#update', as: 'update_post'

  end
  namespace :admin do
    resources :softwares, only: [:index, :create, :edit]
  patch 'softwares/:id' => 'softwares#update', as: 'update_software'
  delete 'softwares/:id' => 'softwares#destroy', as: 'destroy_software'
  end
   scope module: :public do
    resources :bookmarks, only: [:show, :edit, :update]

  end
   scope module: :public do
    resources :posts, only: [:new, :show, :edit, :index]do
  delete 'posts/:id' => 'posts#destroy', as: 'destroy_posts'
    resources :post_comments, only: [:create, :destroy]
  end
    resource :favorites, only: [:create, :destroy]
    patch 'posts/:id' => 'posts#update', as: 'update_post'
    post 'posts' => 'posts#create'
  end
   scope module: :public do
    resources :users, only: [:show, :edit]
    patch 'users/:id' => 'users#update', as: 'update_user'
  end
   scope module: :public do
    resources :users do
    member do
      get :favorites
    end
  end
  end
   scope module: :public do
    resources :lists, only: [:index, :show]
  end

   scope module: :public do
    root to: 'posts#index'
  post '/posts/guest_sign_in', to: 'posts#guest_sign_in'
  end
   scope module: :public do
    resources :notifications, only: [:index]
  end
   scope module: :public do
    resources :boards, only: [:new, :show, :index, :create]do
     delete 'boards/:id' => 'boards#destroy', as: 'destroy_board'
     resources :board_comments, only: [:create]
     delete 'board_comments/:id' => 'board_comments#destroy', as: 'destroy_board_comment'
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
