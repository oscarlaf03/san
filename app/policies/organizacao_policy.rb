class OrganizacaoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.internal?
        scope.all
      else
        scope.where(id: user.organizacao_id)
      end
    end
  end

  def show?
    internal_users_or_record_members_users
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
