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
    internal_or_org_users
  end

  def show?
    internal_or_org_users
  end

  def create?
    user.organizacao?
  end

  def execute?
    only_internal_users
  end

  def cancel?
    only_org_users
  end

  def update?
    internal_or_org_users
  end

end
