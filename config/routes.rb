Rails.application.routes.draw do
  devise_for :users, skip: :registrations, controllers:  { sessions: "sessions", passwords: "passwords"}

  get 'knowledge_base', to: 'knowledge_base#index'
  delete 'knowledge_base/delete_file', to: 'knowledge_base#delete_file'
  delete 'knowledge_base/delete_folder', to: 'knowledge_base#delete_folder'
  post 'knowledge_base/create_folder', to: 'knowledge_base#create_folder'
  post 'knowledge_base/upload_file', to: 'knowledge_base#upload_file'

  get 'download', to: 'downloads#index'
  delete 'downloads/delete_file', to: 'downloads#delete_file'
  delete 'downloads/delete_folder', to: 'downloads#delete_folder'
  post 'downloads/create_folder', to: 'downloads#create_folder'
  post 'downloads/upload_file', to: 'downloads#upload_file'

  delete 'files/delete_file', to: 'files#delete_file'
  delete 'files/delete_folder', to: 'files#delete_folder'
  post 'files/create_folder', to: 'files#create_folder'
  post 'files/upload_file', to: 'files#upload_file'

  post "/upload_file" => "upload#upload_file", as: :upload_file
  post "/upload_image" => "upload#upload_image", as: :upload_image
  get "/download_file/:name" => "upload#access_file", as: :upload_access_file, name: /.*/
  root 'tabs#show'
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale
  get '/admin', to: redirect('/admin/resources')

  resources :tabs, path: '', only: :show

  resource :user, only: [:edit]

  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

  authenticate :user, :admin?.to_proc do
    namespace :admin do
      resources :tabs
      resources :users, only: [:index, :show, :create, :new, :destroy, :edit, :update]
      resources :resources, only: :index
      resources :download_actions, only: [:index, :destroy]
    end
  end
end
