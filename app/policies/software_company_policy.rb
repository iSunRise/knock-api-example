class SoftwareCompanyPolicy < ApplicationPolicy
  def show?
    record.listed || record.id == user.software_company_id
  end

  def update?
    record.id == user.software_company_id
  end
end
