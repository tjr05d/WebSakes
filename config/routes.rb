Rails.application.routes.draw do
  get 'matches/new'

  get 'matches/create'

  get 'matches/update'

  get 'sessions/new'

  post 'users/:id' => 'application#user_clicks_button_to_connect', as: 'user_yes'

  root to:             'static_pages#home'
  get    'help'    =>  'static_pages#help'
  get    'home'    =>  'static_pages#index'
  get    'about'   =>  'static_pages#about'
  get    'contact' =>  'static_pages#contact'
  get    'index'   =>  'static_pages#index'


  get    'signup'  =>  'users#new'
  get    'login'   =>  'sessions#new'
  post   'login'   =>  'sessions#create'
  delete 'logout'  =>  'sessions#destroy'
  resources :users
  resources :sessions

end
