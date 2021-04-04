class CondicaoPolicy < ApplicationPolicy
  def show?
    internal_or_org_users_or_record_member
  end

  def create?
    internal_or_org_users
  end

  def update?
    create?
  end
end
