module AccountTokenDocumentation
  extend ActiveSupport::Concern

  included do
    swagger_controller :account_token, 'Login/Sign Up', resource_path: 'Login'

    swagger_api :create do
      summary 'Sign in with credentials'
      param :form, 'auth[email]', :string, :required, 'Account email'
      param :form, 'auth[password]', :string, :required, 'Account password'
      param :form, 'auth[resend]', :boolean, :optional, 'If resends phone verfication code'
      response :ok, 'Success'
      response :not_found
      response :unprocessable_entity, 'Unprocessable Entity'
    end


    swagger_api :two_factor_auth do
      summary 'Sign in with credentials (2nd step)'
      param :form, 'auth[email]', :string, :required, 'Account email'
      param :form, 'auth[password]', :string, :required, 'Account password'
      param :form, 'auth[phone_verification_code]', :string, :required, 'Phone verfication code (1111 for now)'
      response :ok, 'Success'
      response :not_found
      response :unprocessable_entity, 'Unprocessable Entity'
    end
  end
end
