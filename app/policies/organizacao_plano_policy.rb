class OrganizacaoPlanoPolicy < ApplicationPolicy

  def show?
    internal_or_org_users
  end

  def create?
    only_internal_users
  end

  def update?
    create?
  end

  def destroy?
    only_internal_users
  end
end
