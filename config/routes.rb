Rails.application.routes.draw do

  # ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :show, :update]
  end
  
  # devise_for :users
  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update]

  end
  namespace :admin do
    resources :posts, only: [:index, :show, :edit, :update]

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
    resources :posts, only: [:new, :show, :edit, :index]
    resource :favorites, only: [:create, :destroy]
    patch 'posts/:id' => 'posts#update', as: 'update_post'
    post 'posts' => 'posts#create'
  end
   scope module: :public do
    patch 'users/:id' => 'users#update', as: 'update_user'
    get 'users/show'
    get 'users/edit'

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
    root to: 'homes#top'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

  end
# ゲストログイン


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
