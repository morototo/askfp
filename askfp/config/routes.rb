Rails.application.routes.draw do
  resources :reservations do
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
