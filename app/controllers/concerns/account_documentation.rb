module AccountDocumentation
  extend ActiveSupport::Concern

  included do
    [:show, :create, :update, :destroy].each do |api_action|
      swagger_api api_action do
        param :header, 'Authorization', :string, :required, 'Authentication token'
      end
    end

    swagger_controller :accounts, 'Accounts Controller', resource_path: 'Accounts and Sign Up'

    swagger_api :show do
      summary 'Returns current account'
      response :ok, "Success", :Account
      response :unauthorized
    end

    swagger_api :create do
      summary 'Registers new account and creates a company'
      param :account, 'account[email]', :string, :required, 'Account email'
      param :account, 'account[first_name]', :string, :required, 'First name'
      param :account, 'account[last_name]', :string, :required, 'Last name'
      param :account, 'account[position]', :string, false, 'Position'
      param :account, 'account[phone_number]', :string, :required, 'Phone number'
      param :account, 'account[phone_verification_code]', :string, :required, 'Phone verfication code (1111 for now)'
      param :account, 'account[password]', :string, :required, 'Account password'
      param :account, 'account[software_company_name]', :string, :required, 'New company name (company will be created automatically)'
      response :ok, 'Success', :Account
      response :unauthorized
      response :unprocessable_entity, 'Unprocessable Entity', errors: { field: "can't be blank" }
    end

    swagger_api :update do
      summary 'Updates account record'
      param :account, 'account[first_name]', :string, :optional, 'First name'
      param :account, 'account[last_name]', :string, :optional, 'Last name'
      param :account, 'account[position]', :string, :optional, 'Position'
      param :account, 'account[email]', :string, :optional, 'Account email'
      param :account, 'account[phone_number]', :string, :optional, 'Phone number'
      param :account, 'account[two_factor_auth_enabled]', :boolean, :optional, 'Two factor auth enale/disable'
      param :account, 'account[password]', :string, :optional, 'Account password (if want to update)'
      response :ok, "Success", :Account
      response :unauthorized
      response :unprocessable_entity, 'Unprocessable Entity', errors: { field: "can't be blank" }
    end

    swagger_api :destroy do
      summary 'Removes account record'
      response :ok, 'Success'
      response :unauthorized
    end

  end
end
