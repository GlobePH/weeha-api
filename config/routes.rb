Rails.application.routes.draw do
  post 'users/sign_up', to: 'users/registrations#create'
  post 'users/:username/confirm', to: 'users/registrations#confirm'
  resources :relationships, only: [:create, :destroy] do
    member do
      put 'approve'
    end

    collection do
      get 'pending_requests'
      get 'approved_requests'
    end
  end
  get 'following', to: 'relationships#following'
  get 'follower', to: 'relationships#follower'
  resources :locations, only: [:index, :create] do
    collection do
      get 'last'
    end
  end
end
