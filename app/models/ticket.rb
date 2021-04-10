class Ticket < BaseModel
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', optional: true
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  delegate :organizacao, to: :requestor, allow_nil: true
  validates :name_model, presence: true, constant: true
  validates :action, presence: true, inclusion: { in: %w( create update destroy),
  message: "%{value} não é uma action valida, as ações validas são: ['create', 'update', 'destroy'] "}
  validates :id_model, numericality:{ only_integer: true},  unless: :is_create_action?
  validates :id_model, absence: true, if: :is_create_action?
  validates :params, presence: true, json: true,  unless: :is_destroy_action?
  validate :owner_is_internal_user, :requestor_is_organizacao_user, :points_to_existent_org_record



  def execute!
    return true if executed
    case action
    when 'update'
       if instance.update(**parsed_params)
        close_executed
       else
        copy_errors_from_instance
        false
       end
    when 'create'
      element = constant.new(**parsed_params)
      if element.attributes.keys.include?('organizacao_id')
        element.organizacao_id = self.organizacao.id
      end
       if element.save
        close_executed
       else
        copy_errors_from_instance
        false
       end
    when 'destroy'
       if instance.destroy
        close_executed
       else
        copy_errors_from_instance
        false
       end
    end
  end

  def cancel!
    return true if canceled
    self.update(canceled: true, open: false, closed_at: DateTime.now)
  end


  private

  def is_create_action?
    action == 'create'
  end

  def is_destroy_action?
    action == 'destroy'
  end

  def constant
    name_model.constantize
  end

  def instance
    constant.find(id_model)
  end

  def close_executed
    self.update(open: false, executed: true, closed_at: DateTime.now)
  end

  def parsed_params
    unless is_destroy_action?
      JSON.parse(params).deep_symbolize_keys!
    end
  end

  def copy_errors_from_instance
    self.error.details = instance.error.details
    self.error.messages = instance.error.messages
  end


  def owner_is_internal_user
    if owner.present? && !owner.internal?
      errors.add(:owner, "Só pode ser um usuário interno")
    end
  end

  def requestor_is_organizacao_user
    if requestor.present? && !requestor.organizacao?
      errors.add(:requestor, "Só pode ser um usuário organizacao")
    end
  end

  def same_org?
    if instance.kind_of?(Organizacao)
      errors.add(:id_model, "O 'id_model':#{id_model} para  #{name_model} não pertence a Organizacao do user atual") unless instance == self.organizacao
    elsif instance.respond_to?(:organizacao)
      errors.add(:id_model, "O 'id_model':#{id_model} para  #{name_model} não pertence a Organizacao do user atual") unless instance == self.organizacao unless instance.organizacao == self.organizacao
    else
      errors.add(:id_model, "O 'id_model':#{id_model} para  #{name_model} não response ao método de Organizacao falar com suporte técnico")
    end
  end

  def points_to_existent_org_record
    unless is_create_action?
      begin
        same_org?
      rescue ActiveRecord::RecordNotFound
        errors.add(:id_model, "O 'id_model':#{id_model} não existe para a clase #{name_model}")
      end
    end
  end

end
