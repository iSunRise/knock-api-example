class OfficePolicy < ApplicationAccountPolicy
  def create?
    account.software_company_id == account.software_company_id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope.where(software_company_id: account.software_company_id)
    end
  end
end
