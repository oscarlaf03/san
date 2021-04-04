class SeguradoraPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.internal?
        scope.all
      else
        raise Pundit::NotAuthorizedError, 'Ação não permitida'
      end
    end
  end

  def index?
    user.internal?
  end

  def show?
    only_internal_users
  end

  def create?
    only_internal_users
  end

  def update?
    create?
  end
end
