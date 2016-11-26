Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    scope :v1 do
      post 'login', to: 'account_token#create'
      resources :accounts, only: [:show, :update, :create, :destroy]
      resources :software_companies, only: [:show, :update]
    end
  end
end
