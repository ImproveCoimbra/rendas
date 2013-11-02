Rendas::Application.routes.draw do
  resources :rents


  resources :postal_codes


  resources :postal_codes do
    post :find_geo, :on => :member
  end
  resources :rents
  root :to => 'front#index'

  post '/submit' => 'front#submit'
  get  '/data' => 'front#data'
end
