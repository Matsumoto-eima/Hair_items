Rails.application.routes.draw do

devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  root "public/homes#top"
  get '/about' => 'public/homes#about'
  get '/admin' => 'admin/homes#top'

  namespace :public do
    get 'tagsearches/search', to: 'tagsearches#search'
    get 'users/check'
    get 'users/mypage', to: 'users#show', as: 'mypage'
    get 'users/information/edit', to: 'users#edit', as: 'edit_information'
      patch 'users/information', to: 'users#update'
      patch 'users/withdraw', to: 'users#withdraw'
    get "/relationships/followings" => "relationships#followings" ,as: "followings"
    get "/relationships/followers" => "relationships#followers" ,as: "followers"
     resource :relationships, only: [:create, :destroy]
   end
    resources :items, only: [:index, :show, :edit, :update, :destroy, :create] do
     resource :favorites, only: [:create, :destroy]
     resources :item_comments, only: [:create, :destroy]
   end


  # 顧客用
# URL /customers/sign_in ...


  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
