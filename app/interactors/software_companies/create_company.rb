module SoftwareCompanies
  class CreateCompany
    include Interactor

    def call
      context.software_company = SoftwareCompany.create!(
        name: context.params[:software_company_name]
      )
    end

    def rollback
      context.software_company.destroy
    end
  end
end
