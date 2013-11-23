Rendas::Application.routes.draw do
  resources :postal_codes do
    post :find_geo, :on => :member
  end
  resources :rents do
    get :export, :on => :collection
  end
  root :to => 'front#index'

  post '/submit' => 'front#submit'
  get  '/data' => 'front#data'
end
