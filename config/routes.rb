Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    scope :v1 do
      # generic sign in for all roles
      post 'login', to: 'account_token#create'
      post 'login/two_factor_auth', to: 'account_token#two_factor_auth'

      # software companies
      resource :software_company, only: [:show, :update] do
        scope module: 'software_companies' do
          resources :offices, except: [:show, :edit]
        end
        # resources :accounts
        # resources :invites
      end
      resource :account, only: [:show, :update, :create, :destroy]
      resources :technologies, only: [:index]
      resources :specialties, only: [:index]
      resource :phone_verification, only: [:create]
    end
  end
end
