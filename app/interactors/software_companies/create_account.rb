module SoftwareCompanies
  class CreateAccount
    include Interactor

    def call
      context.account = Account.new(context.params)
      context.account.software_company_id = context.software_company.id
      context.account.save!
    end
  end
end
