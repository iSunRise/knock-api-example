class SoftwareCompaniesController < ApplicationController
  before_action :authenticate_account, except: :create

  def show
    render json: SoftwareCompany.find(params[:id])
  end

  def update
    company = SoftwareCompany.find(params[:id])
    if company.update(company_params)
      render json: company
    else
      render_errors(company)
    end
  end

  private

  def company_params
    params.require(:software_company).permit(
      :name, :url_alias, :website, :about, :logo, :background_photo,
      :number_of_employees, :contacts, :vat, :deleted, :listed
    )
  end
end
