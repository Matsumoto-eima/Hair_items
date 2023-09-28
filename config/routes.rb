Rails.application.routes.draw do

  root "public/homes#top"
  get '/about' => 'public/homes#about'
  get '/admin' => 'admin/homes#top'

  namespace :public do
    get 'tagsearches/search', to: 'tagsearches#search'
    resources :users, only: [:edit,:show,:check,:update] do
    get "/relationships/followings" => "relationships#followings" ,as: "followings"
    get "/relationships/followers" => "relationships#followers" ,as: "followers"
     resource :relationships, only: [:create, :destroy]
   end
    resources :items, only: [:index, :show, :edit, :update, :destroy, :create] do
     resource :favorites, only: [:create, :destroy]
     resources :item_comments, only: [:create, :destroy]
   end
  end

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

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
