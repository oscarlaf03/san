class OrganizacaoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.internal? 
        scope.all
      elsif user.organizacao?
        scope.where(id: [user.org_group_ids])
      else
        raise Pundit::NotAuthorizedError, 'Ação não permitida'
      end
    end
  end

  def show?
    internal_users_or_record_members_users
  end

  def index?
    user.internal? || user.organizacao?
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

  def beneficiarios?
    show?
  end


end
