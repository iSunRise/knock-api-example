class AccountsController < ApplicationController
  include AccountDocumentation if ENV['SWAGGER'].present?
  before_action :authenticate_account, except: :create
  before_action :load_account, except: :create
  after_action :verify_authorized

  def show
    render json: @account
  end

  def create
    authorize Account
    result = SoftwareCompanies::SignUp.call(params: account_params)
    if result.success?
      render json: {
        jwt: Knock::AuthToken.new(payload: result.account.to_token_payload).token
      }
    else
      render_errors(nil, result.errors)
    end
  end

  def update
    if @account.update(account_params)
      render json: @account
    else
      render_errors(@account)
    end
  end

  def destroy
    if @account.destroy
      head :ok
    else
      render_errors(@account)
    end
  end

  private

  def pundit_user
    current_account
  end

  def load_account
    @account = current_account
    authorize @account
  end

  def account_params
    params.require(:account).permit(
      :first_name, :last_name, :middle_name, :position, :email, :password,
      :password_confirmation, :photo, :software_company_name, :phone_number,
      :phone_verification_code
    )
  end
end
