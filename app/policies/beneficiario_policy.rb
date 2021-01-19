class BeneficiarioPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    only_internal_users || self?
  end

  def index?
    internal_users_or_record_members_users(record.organizacao)
  end

  def create?
    only_internal_users
  end

  def update?
    only_internal_users
  end

end
