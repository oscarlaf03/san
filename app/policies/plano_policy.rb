class PlanoPolicy < ApplicationPolicy

  def index?
    only_internal_users
  end

  def create?
    only_internal_users
  end

  def update?
    create?
  end

  def show?
    create?
  end

end
