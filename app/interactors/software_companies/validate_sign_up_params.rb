module SoftwareCompanies
  class ValidateSignUpParams
    include Interactor

    def call
      @account = Account.new(context.params)
      @account.software_company = SoftwareCompany.new
      return if @account.valid? && company_name_valid?

      context.fail!(errors: @account.errors)
    end

    private

    def company_name_valid?
      return true if context.params[:software_company_name].present?
      @account.errors.add(:software_company_name, "can't be blank")
      false
    end
  end
end
