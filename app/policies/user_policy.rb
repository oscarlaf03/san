class UserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.internal?
        scope.all
      elsif user.organizacao?
        scope.where(organizacao_id: user.organizacao_id)
      else
        raise Pundit::NotAuthorizedError, 'Ação não permitida'
      end
    end
  end

  def create?
    internal_or_org_users
  end

  def update?
    internal_or_self
  end

  def show?
    internal_or_self
  end

  def index?
    user.internal? || user.organizacao?
  end

end
