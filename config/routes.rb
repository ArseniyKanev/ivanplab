Rails.application.routes.draw do
  devise_for :users, controllers:  { registrations: "registrations", sessions: "sessions", passwords: "passwords"}

  post "/upload_file" => "upload#upload_file", as: :upload_file
  post "/upload_image" => "upload#upload_image", as: :upload_image

  get "/download_file/:name" => "upload#access_file", as: :upload_access_file, name: /.*/


  devise_scope :user do
    get 'users/send_email', to: 'registrations#send_email'
  end
  root 'tabs#show'

  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale
  get '/admin', to: redirect('/admin/resources')

  resources :tabs, path: '', only: :show

  resource :user, only: [:edit]

  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

  authenticate :user, :admin?.to_proc do
    namespace :admin do
      resources :tabs
      resources :users, only: [:index, :show, :destroy]
      resources :resources, only: :index
    end
  end
end
