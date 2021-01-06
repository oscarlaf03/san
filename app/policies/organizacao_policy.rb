class OrganizacaoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    only_internal_users
  end

  def create?
    only_internal_users
  end

  def update?
    internal_users_or_record_members_users
  end

  def destroy?
    false
  end


end
