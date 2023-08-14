Rails.application.routes.draw do

  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/check'
    resources :items, only: [:index, :show, :edit, :update, :destroy, :create]
  end

  root "public/homes#top"
  get '/about' => 'public/homes#about'
  get '/admin' => 'admin/homes#top'
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
