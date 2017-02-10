Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    scope :v1 do
      # generic sign in for all roles
      post 'login', to: 'account_token#create'

      # software companies
      resource :software_company, only: [:show, :update] do
        # resources :accounts
        # resources :locations
        # resources :invites
      end
      resource :account, only: [:show, :update, :create, :destroy]
      resources :technologies, only: [:index, :create]
    end
  end
end
