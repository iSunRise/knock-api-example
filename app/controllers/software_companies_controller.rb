class SoftwareCompaniesController < ApplicationController
  include SoftwareCompanyDocumentation if ENV['SWAGGER'].present?
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
    @company = current_account.software_company
    authorize @company
  end

  def company_params
    params.require(:software_company).permit(
      :name, :url_alias, :website, :about, :logo, :background_photo,
      :number_of_employees, :contacts, :vat, :deleted, :listed,
      :foundation_date, :average_hairly_rate, :minimum_project_size,
      technologies_names: []
    )
  end

  def pundit_user
    current_account
  end
end
