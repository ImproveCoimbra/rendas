Rendas::Application.routes.draw do
  resources :postal_codes do
    post :find_geo, :on => :member
  end
  resources :rents do
    get :export, :on => :collection
  end
  root :to => 'front#index'

  post '/submit' => 'front#submit'
  get  '/result/:id' => 'front#result'
  get  '/stats' => 'front#stats', :as => :stats
  get  '/sobre' => 'front#about', :as => :about
end
