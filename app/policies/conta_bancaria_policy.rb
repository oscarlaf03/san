class ContaBancariaPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    internal_or_org_users_or_record_member
  end
  
  def create?
    true
  end

  def update?
    only_record_members
  end
end
