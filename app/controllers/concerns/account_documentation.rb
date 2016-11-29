module AccountDocumentation
  extend ActiveSupport::Concern

  included do
    next if ENV['SWAGGER'].blank?
    swagger_controller :accounts, 'Accounts controller'

    swagger_api :show do
      summary 'Returns requested account'
      param :path, :id, :integer, :required, 'Account ID'
    end

    swagger_api :create do
      summary 'Registers new account and creates a company'
      param :account, :first_name, :string, :required, 'First name'
      param :account, :last_name, :string, :required, 'Last name'
      param :account, :position, :string, :required, 'Position'
      param :account, :email, :string, :required, 'Account email'
      param :account, :password, :string, :required, 'Account password'
      param :account, :password, :string, :required, 'Account password confirmation'
      param :account, :software_company_name, :string, :required, 'New company name (will be automatically created)'
    end

    swagger_api :update do
      summary 'Updates account record'
      param :account, :first_name, :string, :optional, 'First name'
      param :account, :last_name, :string, :optional, 'Last name'
      param :account, :position, :string, :optional, 'Position'
      param :account, :email, :string, :optional, 'Account email'
      param :account, :password, :string, :optional, 'Account password'
      param :account, :password, :string, :optional, 'Account password confirmation (required if password set)'
    end

    swagger_api :destroy do
      summary 'Removed account record'
      param :path, :id, :integer, :required, 'Account ID'
    end
  end
end
