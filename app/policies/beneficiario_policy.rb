class BeneficiarioPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.internal?
        scope.all
      elsif user.organizacao?
        scope.where(organizacao_id: user.organizacao_id)
      elsif user.titular?
        scope.where(id: user.id).or(scope.where(titular_id: user.id))
      elsif user.beneficiario?
        scope.where(id: user.id)
      end
    end
  end

  def show?
    internal_or_org_users || self?
  end

  def index?
    internal_users_or_record_members_users(record.organizacao)
  end

  def create?
    internal_or_org_users
  end

  def update?
    update?
  end

end
