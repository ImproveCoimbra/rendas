Rendas::Application.routes.draw do



  resources :postal_codes do
    post :find_geo, :on => :member
  end

  resources :rents do
    get :export, :on => :collection
  end

  resources :hoods do
    get :maps, :on => :collection
  end


  root :to => 'front#index'

  post '/submit' => 'front#submit'
  get  '/result/:id' => 'front#result', :as => :result
  get  '/zonas' => 'front#zonas', :as => :zonas
  get  '/sobre' => 'front#about', :as => :about
  get  '/load'  => 'front#load',  :as => :load
end
