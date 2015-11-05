Rails.application.routes.draw do
  get 'matches/new'

  get 'matches/create'

  get 'matches/update'

  get 'sessions/new'

  root to:             'static_pages#home'
  get    'help'    =>  'static_pages#help'
  get    'about'   =>  'static_pages#about'
  get    'contact' =>  'static_pages#contact'
  get    'signup'  =>  'users#new'
  get    'login'   =>  'sessions#new'
  post   'login'   =>  'sessions#create'
  delete 'logout'  =>  'sessions#destroy'
  resources :users
end
