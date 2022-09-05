Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  get "home/top"=>"homes#top"
  get "home/about"=>"homes#about"
  root to: "homes#top"
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]

  #エラーメッセージが出た画面でリロードした際のエラー回避
  get "books/:id/book_comments" => "book_comments#top"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end