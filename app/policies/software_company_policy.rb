class SoftwareCompanyPolicy < ApplicationAccountPolicy
  def show?
    record.listed || record.id == account.software_company_id
  end

  def update?
    record.id == account.software_company_id
  end
end
