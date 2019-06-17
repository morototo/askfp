Rails.application.routes.draw do
  resources :fp_ng_time_frames, only: [:index, :create]
  resources :profiles, only: [:edit, :update]
  resources :dashboard, only: [:index]
  resources :reservations, only: [:show, :new, :create] do
    collection do
      get 'set_time'
    end
  end

  root 'welcome#index'
  devise_for :users,
    controllers: {
      sessions:            'users/sessions',
      registrations:       'users/registrations',
    } 

  resources :fps, only: [:show] do
    collection do
      get 'search'
    end
  end
end
