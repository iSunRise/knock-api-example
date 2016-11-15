class AccountsController < ApplicationController
  def show
    render json: Account.find(params[:id])
  end

  def create
    account = Account.new(account_params)
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
    account = Account.find(params[:id])
    if account.update(account_params)
      render json: account
    else
      render_errors(account)
    end
  end

  def destroy
    account = Account.find(params[:id])
    if account.destroy
      head :ok
    else
      render_errors(account)
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :first_name, :last_name, :middle_name, :position, :email, :password,
      :password_confirmation, :photo, :software_company_name
    )
  end
end
