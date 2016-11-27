class SoftwareCompaniesController < ApplicationController
  before_action :authenticate_account
  before_action :load_company
  after_action :verify_authorized

  def show
    render json: @company
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render_errors(@company)
    end
  end

  private

  def load_company
    @company = SoftwareCompany.find(params[:id])
    authorize @company
  end

  def company_params
    params.require(:software_company).permit(
      :name, :url_alias, :website, :about, :logo, :background_photo,
      :number_of_employees, :contacts, :vat, :deleted, :listed
    )
  end

  def pundit_user
    current_account
  end
end
