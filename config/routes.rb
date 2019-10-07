Rails.application.routes.draw do
  resources :kinds, :phones
  resources :auths, only: [:create]

  # Seguindo a estrutura abaixo por ser as definições do {json:api}
  scope module: 'v1' do
    resources :contacts do    #, :constraints => lambda{ |request| request.params{:version} == "1" } do -- NÃO FUNCIONA!
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: 'relationships/kind' #funciona por ser belongs_to
  
      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'
      
      resource :phone, only: [:create, :update, :destroy]
      resource :phone, only: [:create, :update, :destroy], path: 'relationships/phone'
  
      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
      
    end
  end

  scope module: 'v2' do
    resources :contacts do    #, :constraints => lambda{ |request| request.params{:version} == "2" } do -- NÃO FUNCIONA!
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: 'relationships/kind' #funciona por ser belongs_to
  
      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'
      
      resource :phone, only: [:create, :update, :destroy]
      resource :phone, only: [:create, :update, :destroy], path: 'relationships/phone'
  
      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
      
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
