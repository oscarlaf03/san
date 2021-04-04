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

  def org_or_nil(record=@record)
    return record if record.kind_of?(Organizacao)
    return record.respond_to?(:organizacao) ? record.send(:organizacao) : nil
  end

  def self?
    record == user
  end

  def only_internal_users
    return false if !user.kind_of?(User)
    user.internal?
  end

  def only_record_members(record=@record)
    return false if record.nil?
    record_name = record.model_name.param_key.to_sym
    user.respond_to?(record_name) ? user.send(record_name) == record : false
  end

  def only_record_members_users(record=@record)
    return false if !user.kind_of?(User)
    only_record_members(record=@record)
  end

  def only_org_users(record=@record)
    return false if !user.kind_of?(User)
    org = org_or_nil(record)
    org ? user.organizacao == org : false
  end


  def internal_users_or_record_members(record=@record)
    only_internal_users || only_record_members(record)
  end

  def internal_users_or_record_members_users(record=@record)
    only_internal_users || only_record_members_users(record)
  end

  def internal_or_org_users(record=@record)
    only_internal_users || only_org_users(record)
  end

  def internal_or_org_users_or_record_member(record=@record)
    internal_or_org_users(record) || only_record_members(record)
  end

  def internal_or_self(record=@record)
    only_internal_users || self?

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
