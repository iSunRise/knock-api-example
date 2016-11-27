class AccountPolicy < ApplicationPolicy
  def show?
    record.id == user.id
  end

  def create?
    user.nil?
  end

  def update?
    record.id == user.id
  end

  def destroy?
    update?
  end
end
