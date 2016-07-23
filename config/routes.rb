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
end
