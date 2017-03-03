module SoftwareCompanies
  class OfficesController < ApplicationController
    include SoftwareCompanies::OfficeDocumentation if ENV['SWAGGER'].present?

    before_action :authenticate_account
    # before_action :load_company
    after_action :verify_authorized, except: :index

    def index
      render json: policy_scope(Office.order('priority ASC'))
    end

    def update
      office = Office.find(params[:id])
      office.assign_attributes(office_params)
      authorize office
      if office.save
        render json: office
      else
        render_errors(office)
      end
    end


    def create
      office = Office.new(office_params)
      office.software_company_id = current_account.software_company_id
      authorize office
      if office.save
        render json: office
      else
        render_errors(office)
      end
    end

    def destroy
      office = Office.find(params[:id])
      authorize office
      office.destroy
      render json: {}
    end

    private

    def office_params
      p = params.require(:office).permit(:country, :city, :details, phones: [],
                                         emails: [])
      if params[:office][:working_times].present?
        p = p.merge({ working_times: params[:office][:working_times].permit! })
      end
      p
    end

    def pundit_user
      current_account
    end
  end
end