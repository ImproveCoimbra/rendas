Rendas::Application.routes.draw do
  resources :hoods


  resources :postal_codes do
    post :find_geo, :on => :member
  end
  resources :rents do
    get :export, :on => :collection
  end
  root :to => 'front#index'

  post '/submit' => 'front#submit'
  get  '/result/:id' => 'front#result', :as => :result
  get  '/stats' => 'front#stats', :as => :stats
  get  '/sobre' => 'front#about', :as => :about
  get  '/load'  => 'front#load',  :as => :load
end
