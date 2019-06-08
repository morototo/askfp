Rails.application.routes.draw do
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
