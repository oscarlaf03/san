class UserPolicy < ApplicationPolicy

  def edit?
    only_internal_users
  end

end
