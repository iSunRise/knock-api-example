class AccountPolicy < ApplicationAccountPolicy
  def show?
    record.id == account.id
  end

  def create?
    true
  end

  def update?
    record.id == account.id
  end

  def destroy?
    update?
  end
end
