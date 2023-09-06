Rails.application.routes.draw do
  root 'statics#top'
  get :dashboard, to: 'teams#dashboard'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resource :user
  
  resources :teams do
  #resources :teams, only: [:index, :show, :new, :create, :edit, :update, :destroy, :change_admin] do
    resources :assigns, only: %w(create destroy)
    resources :agendas, shallow: true do
      resources :articles do
        resources :comments
      end
    end
    member do
      post :change_admin
    end
  end
  

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
