class AccountsController < ApplicationController
  include AccountDocumentation
  before_action :authenticate_account, except: :create
  before_action :load_account, except: :create
  after_action :verify_authorized

  def show
    render json: @account
  end

  def create
    account = Account.new(account_params)
    authorize account
    if account.valid?
      account.software_company = SoftwareCompany.create(
        name: account.software_company_name
      )
      account.save!
      render json: account
    else
      render_errors(account)
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
    @account = Account.find(params[:id])
    authorize @account
  end

  def account_params
    params.require(:account).permit(
      :first_name, :last_name, :middle_name, :position, :email, :password,
      :password_confirmation, :photo, :software_company_name
    )
  end
end
