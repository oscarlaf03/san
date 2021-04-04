class BeneficioPolicy < ApplicationPolicy
  def show?
    internal_or_org_users || only_record_members
  end

  def create?
    internal_or_org_users
  end

  def update?
    create?
  end
  
end
