class TicketPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.internal? 
        scope.all
      elsif user.organizacao?
        scope.select{ |t| t.organizacao == user.organizacao}
      else
        raise Pundit::NotAuthorizedError, 'Ação não permitida'
      end
    end
  end

  def index?
    user.user?
  end

  def show?
    internal_or_org_users
  end

  def create?
    user.organizacao?
  end

  def update?
    internal_or_org_users
  end

end
