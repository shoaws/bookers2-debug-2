Rails.application.routes.draw do
  get 'searches/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  get "home/top"=>"homes#top"
  get "home/about"=>"homes#about"
  root to: "homes#top"
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  #フォロー一覧へのルート
  get 'users/:id/followings' => 'relationships#followings', as: 'followings'
  get 'users/:id/followers' => 'relationships#followers', as: 'followers'

  #検索機能
  get "search" => "searches#search"

  #コメントのエラーメッセージが出た画面でリロードした際のエラー回避
  get "books/:id/book_comments" => "book_comments#top"

  #ゲストユーザーログイン機能
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end