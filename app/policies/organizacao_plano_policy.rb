class OrganizacaoPlanoPolicy < ApplicationPolicy

  def create?
    only_internal_users
  end

  def destroy?
    only_internal_users
  end
end
