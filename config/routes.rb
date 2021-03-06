Rails.application.routes.draw do
  match '/', to: 'application#index', via: [:get], as: 'root'
  post '/upload', to: 'application#upload', as: 'upload'
  post '/download', to: 'application#download', as: 'download'
  # Smoke Tests
  resources :smoketests, only: [:index] do
    collection do
      post 'login'
      delete 'logout'
      get 'cache'
      get 'exception'
    end
  end
end
