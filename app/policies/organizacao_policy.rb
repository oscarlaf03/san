class OrganizacaoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user.organizacao == record  or user.has_role? :backoffice
  end


  def destroy?
    false
  end


end
