class BeneficiarioPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    internal_users_or_record_members(record.organizacao)
  end


  def create?
    true
  end

  def update?
    internal_users_or_record_members(record.organizacao)
  end

end
