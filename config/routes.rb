Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    scope :v1 do
      resources :accounts, only: [:show, :update, :create, :destroy]
    end
  end
end
