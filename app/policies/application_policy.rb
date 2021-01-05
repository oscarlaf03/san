class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def internal_roles
    [:backoffice,:internal]
  end

  def only_internal_users
    internal_roles.each do |role|
      return true if user.has_role? role
    end
    false
  end


  def only_record_members(record=@record)
    record_name = record.model_name.param_key.to_sym
    user.send(record_name) == record
  end

  def internal_users_or_record_members(record=@record)
    only_internal_users || only_record_members(record)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
